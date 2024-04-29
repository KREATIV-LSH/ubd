import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            alignment: AlignmentDirectional(0, -1),
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
                          enabled: dropdownValue != null,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .uraniumConcentration,
                          ),
                          keyboardType: TextInputType.number,
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
                          enabled: dropdownValue != null,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.leadConcentration,
                          ),
                          keyboardType: TextInputType.number,
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
                          enabled: dropdownValue ==
                              AppLocalizations.of(context)!.ratioMethod,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .uraniumConcentration,
                          ),
                          keyboardType: TextInputType.number,
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
                          enabled: dropdownValue ==
                              AppLocalizations.of(context)!.ratioMethod,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.leadConcentration,
                          ),
                          keyboardType: TextInputType.number,
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
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {
                    print("Button pressed");
                  },
                  child: Text(AppLocalizations.of(context)!.calculateButton))),
        ],
      ),
    );
  }
}
