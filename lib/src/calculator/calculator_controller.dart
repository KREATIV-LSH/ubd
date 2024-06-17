import "dart:math";

import "package:flutter/widgets.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:shared_preferences/shared_preferences.dart";

// Object holding a calculation
class Calculation {
  int? methodIndex;
  String? t1;
  String? t2;
  num? result;
  bool? isU235;
  bool? isBackward;

  Calculation(
      {this.methodIndex, this.t1, this.t2, this.isU235, this.isBackward, this.result});
}

class CalculatorController {
  CalculatorController();

  List<Calculation> calculations = [];

  Future<void> addHistory(Calculation calculation) async {
    calculations.add(calculation);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        "calculations",
        calculations
            .map((e) =>
                "${e.methodIndex},${e.t1!},${e.t2!},${e.isU235},${e.isBackward},${e.result!}")
            .toList());
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? history = prefs.getStringList("calculations");
    if (history != null) {
      calculations = history.map((e) {
        final List<String> parts = e.split(",");
        return Calculation(
            methodIndex: int.tryParse(parts[0]),
            t1: parts[1],
            t2: parts[2],
            isU235: bool.tryParse(parts[3]),
            isBackward: bool.tryParse(parts[4]),
            result: num.tryParse(parts[5]));
      }).toList();
    }
  }

  Future<void> clearHistory() async {
    calculations = [];
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("calculations");
  }

  Future<void> deleteHistory(int index) async {
    calculations.removeAt(index);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        "calculations",
        calculations
            .map((e) =>
               "${e.methodIndex},${e.t1!},${e.t2!},${e.isU235},${e.isBackward},${e.result!}")
            .toList());
  }

  // Utils

  num round(num num, int decimals) =>
      (num * pow(10, decimals)).round() / pow(10, decimals);

  String formatNumber(num num, BuildContext context) {
    if (num > 1e9) {
      return "${round(num / 1e9, 3)} ${AppLocalizations.of(context)!.billion}";
    } else if (num > 1e6) {
      return "${round(num / 1e6, 3)} Mio";
    }
    return round(num, 2).toString();
  }

  double log10(num x) => log(x) / ln10;
  double log2(num x) => log(x) / ln2;

  int getMethodIndex(String method, BuildContext context) {
    if (method == AppLocalizations.of(context)!.uraniumPercentageMethod) {
      return 0;
    } else if (method == "U-Radium, 238U -> 206Pb") {
      return 1;
    } else if (method == "U-Actinum, 235U -> 207Pb") {
      return 2;
    } else if (method == AppLocalizations.of(context)!.ratioMethod) {
      return 3;
    } else {
      return -1;
    }
  }

  num tHalf238 = 4.46e10; // Halbwertszeit von u238, 10x grösser
  num tHalf235 = 703.8e7; // Halbwertszeit von u235, 10x grösser
  num lambda238 = 1.55125; // Zerfallskonstante von u238
  num lambda235 = 9.8485; // Zerfallskonstante von u235

  // Calculation
  (bool, String) calculate(String? method, String? t1, String? t2, bool? isU235, bool? isBackward, BuildContext context, {bool saveHistory = true}) {
    bool isError = false;
    String msg = "";
    num t = 0;
    if (method == AppLocalizations.of(context)!.uraniumPercentageMethod) {
      (isError, msg, t) = calculateUraniumPercentage(t1, isU235, isBackward, context);
    } else if (method == "U-Radium, 238U -> 206Pb") {
      (isError, msg, t) = calculateUraniumRadium(t1, t2, context);
    } else if (method == "U-Actinum, 235U -> 207Pb") {
      (isError, msg, t) = calculateUraniumActinum(t1, t2, context);
    } else {
      print("Method not found");
    }

    if (!isError && saveHistory) {
      Calculation calculation = Calculation(
          methodIndex: getMethodIndex(method!, context),
          t1: t1,
          t2: t2,
          isU235: isU235,
          isBackward: isBackward,
          result: t);
      addHistory(calculation);
    }
    return (isError, msg);
  }

  // Calculations

  (bool, String, num) calculateUraniumRadium(
      String? t1, String? t2, BuildContext context) {
    num uranium = num.tryParse(t1!)!;
    num lead = num.tryParse(t2!)!;

    if(uranium == 0) {
      return (false, AppLocalizations.of(context)!.resultZero, 0);
    }

    if(lead == 0) {
      return (false, AppLocalizations.of(context)!.resultInfinity, 0);
    }

    num t = 1 / lambda238 * log(1 + (lead / uranium)) * 1e10;
    return (
      false,
      "≈ ${formatNumber(t, context)} ${AppLocalizations.of(context)!.years}",
      t
    );
  }

  (bool, String, num) calculateUraniumActinum(
      String? t1, String? t2, BuildContext context) {
    num uranium = num.tryParse(t1!)!;
    num lead = num.tryParse(t2!)!;

    if(uranium == 0) {
      return (false, AppLocalizations.of(context)!.resultZero, 0);
    }

    if(lead == 0) {
      return (false, AppLocalizations.of(context)!.resultInfinity, 0);
    }

    num t = 1 / lambda235 * log(1 + (lead / uranium)) * 1e10;
    return (
      false,
      "≈ ${formatNumber(t, context)} ${AppLocalizations.of(context)!.years}",
      t
    );
  }

  (bool, String, num) calculateUraniumPercentage(
      String? t1, bool? isU235, bool? isBackward, BuildContext context) {

    if (isBackward!) {
      return calculateUraniumPercentageBack(t1, isU235, context);
    }
    num uraniumPercentage = num.tryParse(t1!)!;

    if (uraniumPercentage > 100) {
      return (true, AppLocalizations.of(context)!.resultError, 0);
    }

    if (uraniumPercentage > 99.999) {
      return (false, AppLocalizations.of(context)!.resultInfinity, 0);
    }

    if (uraniumPercentage < 0.00001) {
      return (false, AppLocalizations.of(context)!.resultZero, 0);
    }

    num tHalf = isU235! ? tHalf235 : tHalf238;
    num t = -tHalf * log2(uraniumPercentage / 100);
    t /= 10;
    return (
      false,
      "≈ ${formatNumber(t, context)} ${AppLocalizations.of(context)!.years}",
      t
    );
  }

  (bool, String, num) calculateUraniumPercentageBack(String? t1, bool? isU235, BuildContext context) {
    num t = num.tryParse(t1!)!;

    if (t < 0) {
      return (true, AppLocalizations.of(context)!.resultError, 0);
    }

    num tHalf = isU235! ? tHalf235 : tHalf238;
    num uraniumPercentage = 100 * pow(2, -t * 10 / tHalf);
    return (
      false,
      "≈ ${formatNumber(uraniumPercentage, context)} %",
      uraniumPercentage
    );
  }
}
