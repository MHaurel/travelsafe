import 'package:flutter/material.dart';

class CriteriaFormPage extends StatefulWidget {
  const CriteriaFormPage({super.key});

  @override
  State<CriteriaFormPage> createState() => _CriteriaFormPageState();
}

class _CriteriaFormPageState extends State<CriteriaFormPage> {
  @override
  Widget build(BuildContext context) {
    int step = 0;
    List<Step> steps = [
      Step(title: "Titre 1", content: "content 1"),
      Step(title: "Titre 2", content: "content 2"),
      Step(title: "Titre 3", content: "content 3"),
      Step(title: "Titre 4", content: "content 4"),
      Step(title: "Titre 5", content: "content 5"),
      Step(title: "Titre 6", content: "content 6"),
      Step(title: "Titre 7", content: "content 7"),
      Step(title: "Titre 8", content: "content 8"),
    ];

    void _showStepperDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (step > 0) {
                        step--;
                        Navigator.of(context).pop();
                        _showStepperDialog();
                      }
                    });
                  },
                  child: const Text("Précédent")),
              Text("Etape: $step"),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (step < (steps.length - 1)) {
                        step++;
                        Navigator.of(context).pop();
                        _showStepperDialog();
                      }
                    });
                  },
                  child: const Text("Suivant"))
            ],
            content: SingleChildScrollView(
                scrollDirection: Axis.vertical, child: steps[step]),
          );
        },
      );
    }

    void _showBaseDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Bienvenue sur TravelSafe"),
              actions: [
                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _showStepperDialog();
                          },
                          child: const Text("Commencer")), // !
                      TextButton(
                          onPressed: () {}, // !
                          child: const Text("Remplir plus tard"))
                    ],
                  ),
                )
              ],
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: const Text(
                    "Merci d'avoir créé votre compte sur TravelSafe.\nAfin d'optimiser vos recherches de destinatons, nous vous proposons de remplir vos critères de voyage. Ainsi, vous pourrez trouver une destination qui respecte vos contraintes en toute simplicité."),
              ),
            );
          });
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: _showBaseDialog,
            child: const Text("Renseigner les critères")),
      ),
    );
  }
}

class Step extends StatefulWidget {
  const Step({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  State<Step> createState() => _StepState();
}

class _StepState extends State<Step> {
  double _value = 3;

  void _onChanged(double value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              Text(widget.title),
              Text(widget.content),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Slider(
                  label: _value.toString(),
                  divisions: 4,
                  value: _value,
                  onChanged: _onChanged,
                  min: 1,
                  max: 5,
                ),
              )
            ],
          ),
        ),
        IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close))
      ],
    );
  }
}
