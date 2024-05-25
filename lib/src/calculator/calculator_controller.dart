import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ubd/src/settings/settings_service.dart';

class CalculatorController {
  CalculatorController();

  (bool, String) calculate(String? method, String? t1, String? t2, String? t3,
      String? t4, BuildContext context) {
    bool isError = false;
    String msg = "";
    if (method == AppLocalizations.of(context)!.uraniumPercentageMethod) {
      (isError, msg) = calculateUraniumPercentage(t1, context);
    } else if (method == "U-Radium, 238U -> 206Pb") {
    } else if (method == "U-Actinum, 235U -> 207Pb") {
    } else if (method == AppLocalizations.of(context)!.ratioMethod) {
    } else {
      print("Method not found");
    }
    return (isError, msg);
  }

  num tHalf = 4.46 * 10e9;

  (bool,String) calculateUraniumPercentage(String? t1, var context) {
    num uraniumPercentage = num.tryParse(t1!)!;

    if (uraniumPercentage > 100) {
      return (true, AppLocalizations.of(context)!.resultError);
    }
    
    if (uraniumPercentage > 99.999) {
       return (false, AppLocalizations.of(context)!.resultInfinity);
    }

    if(uraniumPercentage < 0.00001) {
      return (false, AppLocalizations.of(context)!.resultZero);
    }

    num t = -tHalf * log2(uraniumPercentage / 100);
    t /= 10;
    return (false, "≈ ${formatNumber(t, context)} ${AppLocalizations.of(context)!.years}");
  }

  num round(num num, int decimals) => (num * pow(10, decimals)).round() / pow(10, decimals);

  String formatNumber(num num, BuildContext context) {
    if(num > 1e9) {
      return "${round(num / 1e9, 3)} ${AppLocalizations.of(context)!.billion}";
    } else if(num > 1e6) {
      return "${round(num / 1e6, 3)} Mio";
    }
    return num.floor().toString();
  }

  double log10(num x) => log(x) / ln10;
  double log2(num x) => log(x) / ln2;
}
