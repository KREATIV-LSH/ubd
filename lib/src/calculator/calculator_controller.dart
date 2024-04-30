

import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalculatorController {
  CalculatorController();

  String calculate(String? method, String? t1, String? t2, String? t3, String? t4, BuildContext context) {
    num t = -1;
    if(method == AppLocalizations.of(context)!.uraniumPercentageMethod) {
      t = calculateUraniumPercentage(t1);
    } else if (method == "U-Radium, 238U -> 206Pb") {

    } else if(method == "U-Actinum, 235U -> 207Pb") {

    } else if(method == AppLocalizations.of(context)!.ratioMethod) {

    } else {
      print("Method not found");
    }
    return t.toString();
  }

  num calculateUraniumPercentage(String? t1) {
    num? uraniumPercentage = num.tryParse(t1!);
    num tHalf = 4.46 * 10e9;

    num t = -tHalf * log2(1 - uraniumPercentage! / 100); // Using log2 instead of log10 and dividing by log10(2) again

    return t;
  }


  double log10(num x) => log(x) / ln10;
  double log2(num x) => log(x) / ln2;

}