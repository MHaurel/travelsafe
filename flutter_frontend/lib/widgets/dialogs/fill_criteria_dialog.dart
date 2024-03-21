import 'package:flutter/material.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/allergia_input_list.dart';
import 'package:flutter_frontend/widgets/base/custom_icon_button.dart';
import 'package:flutter_frontend/widgets/base/custom_slider.dart';
import 'package:flutter_frontend/widgets/base/custom_text_button.dart';
import 'package:flutter_frontend/widgets/base/primary_button.dart';
import 'package:provider/provider.dart';

class FillCriteriaDialog extends StatefulWidget {
  const FillCriteriaDialog({super.key});

  @override
  State<FillCriteriaDialog> createState() => _FillCriteriaDialogState();
}

class _FillCriteriaDialogState extends State<FillCriteriaDialog> {
  int step = 0;
  String errorMsg = "";
  List<int> grades = [3, 3, 3, 3, 3, 3, 3, 3];
  List<TextEditingController> allergiaTypes = [];

  @override
  Widget build(BuildContext context) {
    void onGradeChanged(double grade) {
      grades[step] = grade as int;
    }

    List<Step> steps = [
      Step(
          onGradeChanged: onGradeChanged,
          title:
              "Vous allez maintenant renseigner l'importance du respect des droits des femmes et des enfants.",
          isAllergy: false,
          criteriaName: "Respect du droit des femmes et des enfants",
          errorMsg: errorMsg,
          allergiaControllers: null),
      Step(
          onGradeChanged: onGradeChanged,
          title:
              "Vous allez maintenant renseigner l'importance de la sécurité du pays.",
          isAllergy: false,
          criteriaName: "Sécurité du pays",
          errorMsg: errorMsg,
          allergiaControllers: null),
      Step(
          onGradeChanged: onGradeChanged,
          title:
              "Vous allez maintenant renseigner l'importance des risques sanitaires du pays.",
          isAllergy: false,
          criteriaName: "Risques sanitaires du pays",
          errorMsg: errorMsg,
          allergiaControllers: null),
      Step(
          onGradeChanged: onGradeChanged,
          title:
              "Vous allez maintenant renseigner l'importance du climat sociopolitique du pays.",
          isAllergy: false,
          criteriaName: "Climat sociopolitique du pays",
          errorMsg: errorMsg,
          allergiaControllers: null),
      Step(
          onGradeChanged: onGradeChanged,
          title:
              "Vous allez maintenant renseigner l'importance des conséquences liées au changement climatique dans le pays visité.",
          isAllergy: false,
          criteriaName:
              "Conséquences liées au changement climatique dans le pays visité",
          errorMsg: errorMsg,
          allergiaControllers: null),
      Step(
          onGradeChanged: onGradeChanged,
          title:
              "Vous allez maintenant renseigner l'importance des us et coutumes du pays.",
          isAllergy: false,
          criteriaName: "Us et coutumes du pays",
          errorMsg: errorMsg,
          allergiaControllers: null),
      Step(
        onGradeChanged: onGradeChanged,
        title:
            "Vous allez maintenant renseigner l'importance du respect des droits LGBTQ+.",
        isAllergy: false,
        criteriaName: "Respect des droits LGBTQ+",
        errorMsg: errorMsg,
        allergiaControllers: null,
      ),
      Step(
        onGradeChanged: onGradeChanged,
        title:
            "Vous allez maintenant renseigner l'importance des allergies alimentaires dans le pays.",
        isAllergy: true,
        criteriaName: "Allergies alimentaires dans le pays",
        errorMsg: errorMsg,
        allergiaControllers: allergiaTypes,
      ),
    ];

    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        PrimaryButton(
          onPressed: () {
            if (step > 0) {
              setState(() {
                step--;
              });
            }
          },
          text: "Précédent",
        ),
        StepperIndicator(stepIndex: step),
        PrimaryButton(
          onPressed: () async {
            Map<String, dynamic> body = {
              "name": steps[step].criteriaName,
              "grade": grades[step],
              "types": step == 7
                  ? allergiaTypes.map((e) => {"name": e.text}).toList()
                  : []
            };

            bool hasWorked =
                await context.read<UserProvider>().addCriteria(body);

            if (hasWorked) {
              setState(() {
                errorMsg = "";
              });
              if (step < (steps.length - 1)) {
                setState(() {
                  step++;
                });
              } else {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, "/profile");
              }
            } else {
              setState(() {
                errorMsg =
                    "Nous n'avons pas pu renseigner ce critère, veuillez réessayer plus tard.";
              });
            }
          },
          text: "Suivant",
        )
      ],
      content: SingleChildScrollView(
          scrollDirection: Axis.vertical, child: steps[step]),
    );
  }
}

class Step extends StatefulWidget {
  const Step(
      {super.key,
      required this.title,
      required this.isAllergy,
      required this.criteriaName,
      required this.onGradeChanged,
      required this.errorMsg,
      required this.allergiaControllers});

  final String title;
  final bool isAllergy;
  final String criteriaName;
  final Function(double grade) onGradeChanged;
  final String errorMsg;
  final List<TextEditingController>? allergiaControllers;

  @override
  State<Step> createState() => _StepState();
}

class _StepState extends State<Step> {
  void _onChanged(double value) {
    widget.onGradeChanged(value);
  }

  bool _isOneControllerEmpty(List<TextEditingController> controllers) {
    for (int i = 0; i <= controllers.length; i++) {
      if (controllers[i].text == "") {
        return true;
      }
    }
    return false;
  }

  void _addAllergiaType() {
    // TODO: call the above method
    setState(() {
      widget.allergiaControllers!.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Column(
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                widget.isAllergy
                    ? AllergiaInputList(
                        controllers: widget.allergiaControllers!)
                    : const SizedBox(),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 30.0, left: 64, right: 64),
                    child: CustomSlider(onChanged: _onChanged)),
                widget.isAllergy
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 32),
                        child: Row(
                          children: [
                            CustomIconButton(
                                icon: Icons.add,
                                onPressed: _addAllergiaType,
                                text: "Ajouter un type d'allergie"),
                          ],
                        ),
                      )
                    : const SizedBox(),
                Text(
                  widget.errorMsg,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                )
              ],
            ),
          ),
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close))
        ],
      ),
    );
  }
}

class StepperIndicator extends StatelessWidget {
  const StepperIndicator({super.key, required this.stepIndex});

  final int stepIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 10,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index) => Dot(active: index <= stepIndex),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key, required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            color: active ? const Color(0xFF478B85) : const Color(0xFFD7D7D7),
            borderRadius: BorderRadius.circular(80)),
      ),
    );
  }
}
