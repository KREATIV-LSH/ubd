import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ubd/src/calculator/calculator_controller.dart';

import 'histroy_view.dart';
import '../settings/settings_view.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/';

  final CalculatorController controller;

  @override
  _CalculatorViewState createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String? dropdownValue;
  String result = "";
  bool isError = false;

  final TextEditingController t1 = TextEditingController();
  final TextEditingController t2 = TextEditingController();
  final TextEditingController t3 = TextEditingController();
  final TextEditingController t4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.controller.loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle,
            style: const TextStyle(fontSize: 35)),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.history,
              size: 35,
            ),
            onPressed: () {
              Navigator.restorablePushNamed(context, HistoryView.routeName);
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
          DropdownButton<String>(
            value: dropdownValue,
            hint: Text(AppLocalizations.of(context)!.methodHint,
                style: const TextStyle(fontSize: 20)),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>[
              AppLocalizations.of(context)!.uraniumPercentageMethod,
              "U-Radium, 238U -> 206Pb",
              "U-Actinum, 235U -> 207Pb",
              AppLocalizations.of(context)!.ratioMethod
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(fontSize: 20)),
              );
            }).toList(),
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
                            labelText: AppLocalizations.of(context)!
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
                                  ',', '.'); // Replace commas with periods
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
                                  ',', '.'); // Replace commas with periods
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
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Visibility(
              visible:
                  dropdownValue == AppLocalizations.of(context)!.ratioMethod,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            controller: t3,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!
                                  .uraniumConcentration,
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
                                    ',', '.'); // Replace commas with periods
                                return text.isEmpty
                                    ? newValue.copyWith(text: text)
                                    : double.tryParse(text) == null
                                        ? oldValue
                                        : newValue.copyWith(text: text);
                              }),
                            ],
                          ))),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            controller: t4,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!
                                  .leadConcentration,
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
                                    ',', '.'); // Replace commas with periods
                                return text.isEmpty
                                    ? newValue.copyWith(text: text)
                                    : double.tryParse(text) == null
                                        ? oldValue
                                        : newValue.copyWith(text: text);
                              }),
                            ],
                          ))),
                ],
              ),
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
                      var temp = widget.controller.calculate(dropdownValue,
                          t1.text, t2.text, t3.text, t4.text, context);
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
