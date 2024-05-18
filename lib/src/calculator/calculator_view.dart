import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ubd/src/calculator/calculator_controller.dart';

import '../settings/settings_view.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  @override
  _CalculatorViewState createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String? dropdownValue;
  String result = "";

  final CalculatorController controller = CalculatorController();

  final TextEditingController t1 = TextEditingController();
  final TextEditingController t2 = TextEditingController();
  final TextEditingController t3 = TextEditingController();
  final TextEditingController t4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
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
            ),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            hint: Text(AppLocalizations.of(context)!.methodHint),
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
                child: Text(value),
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
                                .uraniumConcentration,
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true, signed: false),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9.]")),
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              final text = newValue.text;
                              return text.isEmpty
                                  ? newValue
                                  : double.tryParse(text) == null
                                      ? oldValue
                                      : newValue;
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
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true, signed: false),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9.]")),
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              final text = newValue.text;
                              return text.isEmpty
                                  ? newValue
                                  : double.tryParse(text) == null
                                      ? oldValue
                                      : newValue;
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
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true, signed: false),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9.]")),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                final text = newValue.text;
                                return text.isEmpty
                                    ? newValue
                                    : double.tryParse(text) == null
                                        ? oldValue
                                        : newValue;
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
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true, signed: false),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9.]")),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                final text = newValue.text;
                                return text.isEmpty
                                    ? newValue
                                    : double.tryParse(text) == null
                                        ? oldValue
                                        : newValue;
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
                        horizontal: 100, vertical: 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (dropdownValue == null) {
                      return;
                    }
                    setState(() {
                      result = controller.calculate(dropdownValue, t1.text,
                          t2.text, t3.text, t4.text, context);
                    });
                  },
                  child: Text(
                    AppLocalizations.of(context)!.calculateButton,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ))),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  result,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (result.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: result.substring(2)));
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
