import "package:flutter/material.dart";
import "package:flutter_math_fork/flutter_math.dart";
import "package:url_launcher/url_launcher.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

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
                                const url =
                                    "https://datierung.ch/media/Datenschutz_06.06.24.pdf";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw "Could not launch $url";
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
                        Expanded(child: contentColumn1(context)),
                        const SizedBox(width: 16),
                        Expanded(child: contentColumn2(context)),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        contentColumn1(context),
                        const SizedBox(height: 16),
                        contentColumn2(context),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget contentColumn1(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.infoTitle,
            style: const TextStyle(
                fontSize: textSize + 5, fontWeight: FontWeight.bold)),
        Text(AppLocalizations.of(context)!.infoDetails,
            style: const TextStyle(fontSize: textSize - 5)),
        Text(AppLocalizations.of(context)!.basicsTitle,
            style: const TextStyle(fontSize: textSize + 5)),
        Text(AppLocalizations.of(context)!.basicsDetails,
            style: const TextStyle(fontSize: textSize - 5)),
        Text("\n${AppLocalizations.of(context)!.credits}",
            style: const TextStyle(fontSize: textSize, fontStyle: FontStyle.italic)),
      ],
    );
  }

  Widget contentColumn2(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.simpleDecay,
            style:
                const TextStyle(fontSize: textSize + 5, fontWeight: FontWeight.bold)),
        Text(AppLocalizations.of(context)!.definitions,
            style: const TextStyle(fontSize: textSize)),
        Math.tex(AppLocalizations.of(context)!.halflife,
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Math.tex(AppLocalizations.of(context)!.initialUraniumAmount,
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Math.tex(AppLocalizations.of(context)!.currentUraniumAmount,
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Text(
          AppLocalizations.of(context)!.formula,
          style: const TextStyle(fontSize: textSize),
        ),
        Math.tex("N_u(t)=N_u(0)\\cdot 2^{\\frac{-t}{T_{1/2}}}",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Text(
          AppLocalizations.of(context)!.transformationToT,
          style: const TextStyle(fontSize: textSize),
        ),
        Math.tex("t = \\frac{-T_{1/2}\\cdot log_{10}(X)}{log_{10}(2)}",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Math.tex("t = -T_{1/2}\\cdot log_2(X)",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Text(AppLocalizations.of(context)!.advancedDecay,
            style:
                const TextStyle(fontSize: textSize + 5, fontWeight: FontWeight.bold)),
        Text(AppLocalizations.of(context)!.definitions, style: const TextStyle(fontSize: textSize)),
        Math.tex(
            AppLocalizations.of(context)!.leadIsotope,
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Math.tex(AppLocalizations.of(context)!.uraniumIsotope,
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Math.tex(
            AppLocalizations.of(context)!.decayConstant,
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Math.tex(
            r"\lambda_{238} = \frac{\ln 2}{T_{1/2}} \approx 1.55125 \cdot 10^{-10}",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Text(AppLocalizations.of(context)!.formula, style: const TextStyle(fontSize: textSize)),
        Math.tex(
            r"^{206}\mathrm{Pb} = ^{238}\mathrm U \cdot (1-e^{-\lambda_{238} t})",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Text(AppLocalizations.of(context)!.transformationToT, style: const TextStyle(fontSize: textSize)),
        Math.tex(
            r"t = \frac{1}{\lambda_{238}} \cdot \ln \left( 1+ \frac{^{206}\mathrm{Pb}}{^{238}\mathrm U} \right)",
            mathStyle: MathStyle.textCramped,
            textStyle: const TextStyle(fontSize: mathSize)),
        Text(
            AppLocalizations.of(context)!.isotopeInfo,
            style: const TextStyle(
                fontSize: textSize - 5,
                fontStyle: FontStyle.italic)),
      ],
    );
  }
}
