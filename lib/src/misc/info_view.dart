import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class InfoView extends StatelessWidget {

  static const routeName = '/info';
  static const double mathSize = 18;
  static const double textSize = 23;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Einfaches Zerfallsgesetz:', style: TextStyle(fontSize: textSize + 5, fontWeight: FontWeight.bold)),
            const Text("Defenitionen:", style: TextStyle(fontSize: textSize)),
            Math.tex(r'T_{1/2}: \text{Halbwertszeit von } ^{238}U', mathStyle: MathStyle.textCramped, textStyle: const TextStyle(fontSize: mathSize)),
            Math.tex(r'N_u(0): \text{Anzahl } ^{238}U\text{ zum Zeitpunkt 0}', mathStyle: MathStyle.textCramped, textStyle: const TextStyle(fontSize: mathSize)),
            Math.tex(r'N_u(t): \text{Anzahl } ^{238}U\text{ zum Zeitpunkt t}', mathStyle: MathStyle.textCramped, textStyle: const TextStyle(fontSize: mathSize)),
            const Text('Formel:', style: TextStyle(fontSize: textSize)),
            Math.tex(r'N_u(t)=N_u(0)\cdot 2^{\frac{-t}{T_{1/2}}}', mathStyle: MathStyle.textCramped, textStyle: const TextStyle(fontSize: mathSize)),
            const Text('Umformung nach t:', style: TextStyle(fontSize: textSize)),
            Math.tex(r't = \frac{-T_{1/2}\cdot log_{10}(X)}{log_{10}(2)}', mathStyle: MathStyle.textCramped, textStyle: const TextStyle(fontSize: mathSize)),
            Math.tex(r't = -T_{1/2}\cdot log_2(X)', mathStyle: MathStyle.textCramped, textStyle: const TextStyle(fontSize: mathSize)),
            const Text('Erweitertes Zerfallsgesetz:', style: TextStyle(fontSize: textSize + 5, fontWeight: FontWeight.bold)),
            const Text("Defenitionen:", style: TextStyle(fontSize: textSize)),
            Math.tex(r"^{206}\mathrm{Pb}: \text{Bleiisotop } ^{206}\mathrm{Pb}, \text{ Zerfallsprodukt}", mathStyle: MathStyle.textCramped, textStyle: const TextStyle(fontSize: mathSize)),
            Math.tex(r"^{238}\mathrm U: \text{Uranisotop } ^{238}\mathrm U, \text{ Ursprungsisotop}", mathStyle: MathStyle.textCramped, textStyle: const TextStyle(fontSize: mathSize)),
            Math.tex(r"\lambda_{238}: \text{Zerfallskonstante von } ^{238}\mathrm U", mathStyle: MathStyle.textCramped, textStyle: const TextStyle(fontSize: mathSize)),
            Math.tex(r"\lambda_{238} = \frac{\ln 2}{T_{1/2}} \approx 1.55125 \cdot 10^{-10} / Jahr", mathStyle: MathStyle.textCramped, textStyle: const TextStyle(fontSize: mathSize)),
            const Text("Formel:", style: TextStyle(fontSize: textSize)),
            Math.tex(r"^{206}\mathrm{Pb} = ^{238}\mathrm U \cdot (1-e^{-\lambda_{238} t})", mathStyle: MathStyle.textCramped, textStyle: const TextStyle(fontSize: mathSize)),
            const Text("Umformung nach t:", style: TextStyle(fontSize: textSize)),
            Math.tex(r"t = \frac{1}{\lambda_{238}} \cdot \ln \left( 1+ \frac{^{206}\mathrm{Pb}}{^{238}\mathrm U} \right)", mathStyle: MathStyle.textCramped, textStyle: const TextStyle(fontSize: mathSize))
          ],
        ),
      ),
    );
  }
}