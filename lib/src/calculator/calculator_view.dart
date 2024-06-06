import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:ubd/src/calculator/calculator_controller.dart";

import "../misc/info_view.dart";
import "../settings/settings_controller.dart";
import "histroy_view.dart";
import "../settings/settings_view.dart";

class CalculatorView extends StatefulWidget {
  const CalculatorView(
      {Key? key,
      required this.controller,
      this.calculation,
      this.settingsController})
      : super(key: key);

  static const routeName = "/";

  final CalculatorController controller;
  final Calculation? calculation;
  final SettingsController? settingsController;

  @override
  _CalculatorViewState createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String? dropdownValue;
  String uraniumType = "U 238";
  String result = "";
  bool isError = false;
  bool isBackward = false;

  final TextEditingController t1 = TextEditingController();
  final TextEditingController t2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkFirstVisit();
  }

  void checkFirstVisit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstVisit = prefs.getBool("isFirstVisit") ?? true;
    if (isFirstVisit) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: RichText(
            text: TextSpan(
              style: Theme.of(context).brightness == Brightness.dark
                  ? const TextStyle(color: Colors.black)
                  : const TextStyle(color: Color.fromARGB(255, 202, 201, 201)),
              children: <TextSpan>[
                TextSpan(
                    text: AppLocalizations.of(context)!.legalLocationNotice),
                TextSpan(
                  text: "Info",
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, InfoView.routeName);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                ),
                TextSpan(
                  children: <InlineSpan>[
                    const TextSpan(text: " > "),
                    WidgetSpan(
                      child: Icon(
                        Icons.description,
                        size: 14,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    const TextSpan(text: " Legal"),
                  ],
                ),
              ],
            ),
          ),
          duration: const Duration(seconds: 10),
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
        ),
      );

      await prefs.setBool("isFirstVisit", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle,
            style: const TextStyle(fontSize: 35)),
        actions: [
          IconButton(
            icon: const Icon(Icons.info, size: 35),
            onPressed: () {
              Navigator.pushNamed(context, InfoView.routeName);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.history,
              size: 35,
            ),
            onPressed: () {
              Navigator.pushNamed(context, HistoryView.routeName).then((rtrn) {
                if (rtrn != null) {
                  Calculation calculation = rtrn as Calculation;
                  setState(() {
                    dropdownValue = <String>[
                      AppLocalizations.of(context)!.uraniumPercentageMethod,
                      "U-Radium, 238U -> 206Pb",
                      "U-Actinum, 235U -> 207Pb",
                    ][calculation.methodIndex!];
                    t1.text = calculation.t1 ?? "";
                    t2.text = calculation.t2 ?? "";
                    uraniumType = calculation.isU235 ?? false ? "U 235" : "U 238";
                    isBackward = calculation.isBackward ?? false;
                    var temp = widget.controller.calculate(
                        dropdownValue,
                        t1.text,
                        t2.text,
                        calculation.isU235 ?? false,
                        isBackward,
                        context,
                        saveHistory: false);
                    isError = temp.$1;
                    result = temp.$2;
                  });
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              size: 35,
            ),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Align(
            alignment: const AlignmentDirectional(0, -1),
            child: Text(
              AppLocalizations.of(context)!.methodPromt,
              style: const TextStyle(fontSize: 25),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: dropdownValue,
                  hint: Text(AppLocalizations.of(context)!.methodHint,
                      style: const TextStyle(fontSize: 20)),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      t1.clear();
                      t2.clear();
                    });
                  },
                  items: <String>[
                    AppLocalizations.of(context)!.uraniumPercentageMethod,
                    "U-Radium, 238U -> 206Pb",
                    "U-Actinum, 235U -> 207Pb",
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(fontSize: 20)),
                    );
                  }).toList(),
                ),
                Visibility(
                  visible: dropdownValue ==
                      AppLocalizations.of(context)!.uraniumPercentageMethod,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<String>(
                          value: uraniumType,
                          onChanged: (String? newValue) {
                            setState(() {
                              uraniumType = newValue!;
                            });
                          },
                          items: <String>[
                            "U 238",
                            "U 235",
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: const TextStyle(fontSize: 20)),
                            );
                          }).toList(),
                        ),
                      ),
                      Tooltip(
                        message:
                            AppLocalizations.of(context)!.calculateBackwards,
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.calculate),
                                Icon(Icons.undo),
                              ],
                            ),
                            Switch(
                              value: isBackward,
                              onChanged: (bool value) {
                                setState(() {
                                  isBackward = value;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: t1,
                          enabled: dropdownValue != null,
                          decoration: InputDecoration(
                            labelText: isBackward ? AppLocalizations.of(context)!.resultText : AppLocalizations.of(context)!
                                    .uraniumConcentration +
                                (dropdownValue ==
                                        AppLocalizations.of(context)!
                                            .uraniumPercentageMethod
                                    ? " in %"
                                    : ""),
                            labelStyle: const TextStyle(fontSize: 20),
                          ),
                          style: const TextStyle(fontSize: 20),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true, signed: false),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9.,]")), // Allow commas
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              final text = newValue.text.replaceAll(
                                  ",", "."); // Replace commas with periods
                              return text.isEmpty
                                  ? newValue.copyWith(text: text)
                                  : double.tryParse(text) == null
                                      ? oldValue
                                      : newValue.copyWith(text: text);
                            }),
                          ],
                        ))),
                Visibility(
                  visible: dropdownValue != null &&
                      dropdownValue !=
                          AppLocalizations.of(context)!.uraniumPercentageMethod,
                  child: Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: t2,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.leadConcentration,
                            labelStyle: const TextStyle(fontSize: 20),
                          ),
                          style: const TextStyle(fontSize: 20),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true, signed: false),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9.,]")), // Allow commas
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              final text = newValue.text.replaceAll(
                                  ",", "."); // Replace commas with periods
                              return text.isEmpty
                                  ? newValue.copyWith(text: text)
                                  : double.tryParse(text) == null
                                      ? oldValue
                                      : newValue.copyWith(text: text);
                            }),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF18c95f),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (dropdownValue == null) {
                      return;
                    }
                    setState(() {
                      bool isU235 = uraniumType == "U 235";
                      var temp = widget.controller.calculate(dropdownValue,
                          t1.text, t2.text, isU235, isBackward, context);
                      isError = temp.$1;
                      result = temp.$2;
                    });
                  },
                  child: Text(
                    AppLocalizations.of(context)!.calculateButton,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ))),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    result.isEmpty
                        ? ""
                        : isError
                            ? result
                            : AppLocalizations.of(context)!.resultText + result,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: isError
                          ? Colors.red
                          : Theme.of(context).textTheme.titleMedium!.color,
                    ),
                  ),
                ),
                if (result.isNotEmpty && !isError)
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: result));
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
