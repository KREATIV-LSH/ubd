import "package:flutter/material.dart";
import "package:ubd/src/calculator/calculator_controller.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class HistoryView extends StatefulWidget {
  final CalculatorController controller;

  const HistoryView({Key? key, required this.controller}) : super(key: key);

  static const routeName = "/history";

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.historyTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              widget.controller.clearHistory();
              setState(() {}); // This will trigger a rebuild of the widget
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.controller.calculations.length,
        itemBuilder: (context, index) {
          final Calculation calculation = widget.controller.calculations[index];
          String subtitle = "";
          String result =
              widget.controller.formatNumber(calculation.result!, context);
          if (calculation.methodIndex == 0) {
            if (calculation.isBackward!) {
              subtitle = "${calculation.t1!} ${AppLocalizations.of(context)!.years}: $result%";
            } else {
              subtitle = "${calculation.t1!}%: $result";
            }
          } else {
            subtitle = "${calculation.t1!}, ${calculation.t2!}: $result${AppLocalizations.of(context)!.years}";
          }
          final isHovered = ValueNotifier<bool>(false);

          return MouseRegion(
            onHover: (_) => isHovered.value = true,
            onExit: (_) => isHovered.value = false,
            child: ListTile(
              onTap: () {
                Navigator.pop(context, calculation); // Return the calculation to the previous screen (CalculatorView)
              },
              title: Text(<String>[
                AppLocalizations.of(context)!.uraniumPercentageMethod,
                "U-Radium, 238U -> 206Pb",
                "U-Actinum, 235U -> 207Pb",
              ][calculation.methodIndex!]),
              subtitle: Text(subtitle),
              trailing: ValueListenableBuilder<bool>(
                valueListenable: isHovered,
                builder: (context, value, child) {
                  return Visibility(
                    visible: value,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        widget.controller.deleteHistory(index);
                        setState(
                            () {}); // This will trigger a rebuild of the widget
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
