import "package:flutter/material.dart";
import "package:flutter_math_fork/flutter_math.dart";
import "package:url_launcher/url_launcher.dart";

class InfoView extends StatelessWidget {
  static const routeName = "/info";
  static const double mathSize = 18;
  static const double textSize = 23;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info"),
        actions: [
          IconButton(
            icon: const Icon(Icons.description, size: 35),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Legal / Impressum"),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("© 2024 - Alle Rechte vorbehalten.\n\n"
                              "Verantwortlicher / Kontakt:\n"
                              "Luis Hutterli\n"
                              "Bärenstrasse 24, 8280 Kreuzlingen, Schweiz\n"
                              "079 874 04 48 - luis.hutterli@stud.kftg.ch\n\n"
                              "Urheberrechtshinweis:\n"
                              "Alle Inhalte und Werke auf dieser Website, einschließlich Quellcode, sind das Eigentum von Luis Hutterli und dürfen ohne ausdrückliche schriftliche Genehmigung nicht kopiert, modifiziert, veröffentlicht, übertragen, verteilt oder auf andere Weise verwendet werden.\n\n"
                              "Datenschutzhinweis:\n"
                              "Durch die Nutzung dieses Dienstes erklären Sie sich damit einverstanden, dass Ihre Nutzungsdaten möglicherweise durch uns oder Dritte gespeichert und verarbeitet werden.\nDie Verarbeiteten Daten sind anonymisiert und lassen sich nicht auf Sie zurückführen.\nIhre Einstellungen und Präferenzen werden nur lokal auf Ihrem Gerät gespeichert.\nMögliche Dritte: Google, Cloudflare, Firebase\n"),
                          TextButton(
                              onPressed: () async {
                                const url = 'https://datierung.ch/media/Datenschutz_06.06.24.pdf';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: const Text(
                                "Datenschutz_06.06.24.pdf",
                              ))
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            tooltip: "Legal",
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isWideScreen = constraints.maxWidth > 700;
              return isWideScreen
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: contentColumn1()),
                        const SizedBox(width: 16),
                        Expanded(child: contentColumn2()),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        contentColumn1(),
                        const SizedBox(height: 16),
                        contentColumn2(),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget contentColumn1() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Uran Blei Datierung:",
            style:
                TextStyle(fontSize: textSize + 5, fontWeight: FontWeight.bold)),
        Text(
            "Die Uran-Blei-Datierung ist eine Methode der radiometrischen Datierung, die auf dem Zerfall von Uran-Isotopen zu Blei basiert. Diese Methode ist besonders nützlich für die Bestimmung des Alters von Gesteinen und Mineralien.",
            style: TextStyle(fontSize: textSize - 5)),
        Text("Grundlagen der Uran-Blei-Datierung:",
            style: TextStyle(fontSize: textSize + 5)),
        Text(
            "Uran-Isotope sind instabil und zerfallen mit der Zeit zu Blei-Isotopen. Der Zerfall von Uran-Isotopen zu Blei-Isotopen erfolgt in mehreren Schritten über Zwischenprodukte wie Thorium-Isotope. Schlussendlich bleibt Blei-206 bzw. Blei-207 übrig, da diese Isotope stabil sind.",
            style: TextStyle(fontSize: textSize - 5)),
      ],
    );
  }

  Widget contentColumn2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Einfaches Zerfallsgesetz:",
            style:
                TextStyle(fontSize: textSize + 5, fontWeight: FontWeight.bold)),
        const Text("Definitionen:", style: TextStyle(fontSize: textSize)),
        Math.tex(r"T_{1/2}: \text{Halbwertszeit von } ^{238}U",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Math.tex(r"N_u(0): \text{Anzahl } ^{238}U\text{ zum Zeitpunkt 0}",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Math.tex(r"N_u(t): \text{Anzahl } ^{238}U\text{ zum Zeitpunkt t}",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        const Text("Formel:", style: TextStyle(fontSize: textSize)),
        Math.tex(r"N_u(t)=N_u(0)\cdot 2^{\frac{-t}{T_{1/2}}}",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        const Text("Umformung nach t:", style: TextStyle(fontSize: textSize)),
        Math.tex(r"t = \frac{-T_{1/2}\cdot log_{10}(X)}{log_{10}(2)}",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Math.tex(r"t = -T_{1/2}\cdot log_2(X)",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        const Text("Erweitertes Zerfallsgesetz:",
            style:
                TextStyle(fontSize: textSize + 5, fontWeight: FontWeight.bold)),
        const Text("Definitionen:", style: TextStyle(fontSize: textSize)),
        Math.tex(
            r"^{206}\mathrm{Pb}: \text{Bleiisotop}, \text{ Zerfallsprodukt}",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Math.tex(r"^{238}\mathrm U: \text{Uranisotop}, \text{ Ursprungsisotop}",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Math.tex(
            r"\lambda_{238}: \text{Zerfallskonstante von } ^{238}\mathrm U",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Math.tex(
            r"\lambda_{238} = \frac{\ln 2}{T_{1/2}} \approx 1.55125 \cdot 10^{-10} / Jahr",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        const Text("Formel:", style: TextStyle(fontSize: textSize)),
        Math.tex(
            r"^{206}\mathrm{Pb} = ^{238}\mathrm U \cdot (1-e^{-\lambda_{238} t})",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        const Text("Umformung nach t:", style: TextStyle(fontSize: textSize)),
        Math.tex(
            r"t = \frac{1}{\lambda_{238}} \cdot \ln \left( 1+ \frac{^{206}\mathrm{Pb}}{^{238}\mathrm U} \right)",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize))
      ],
    );
  }
}
