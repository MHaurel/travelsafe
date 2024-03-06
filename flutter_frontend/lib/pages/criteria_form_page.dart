import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/user.dart';
import 'package:flutter_frontend/widgets/allergia_input_list.dart';
import 'package:flutter_frontend/widgets/base/custom_icon_button.dart';
import 'package:flutter_frontend/widgets/base/custom_slider.dart';
import 'package:flutter_frontend/widgets/base/custom_text_button.dart';
import 'package:flutter_frontend/widgets/base/primary_button.dart';
import 'package:provider/provider.dart';

class CriteriaFormPage extends StatefulWidget {
  const CriteriaFormPage({super.key});

  @override
  State<CriteriaFormPage> createState() => _CriteriaFormPageState();
}

class _CriteriaFormPageState extends State<CriteriaFormPage> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    int step = 7;
    List<int> grades = [3, 3, 3, 3, 3, 3, 3, 3];
    // List<String> allergiaTypes = []; // TODO: use this

    void onGradeChanged(double grade) {
      grades[step] = grade as int;
    }

    List<Step> steps = [
      Step(
          onGradeChanged: onGradeChanged,
          title:
              "Vous allez maintenant renseigner l'importance du respect des droits des femmes et des enfants.",
          isAllergy: false,
          criteriaName: "Respect du droit des femmes et des enfants"),
      Step(
          onGradeChanged: onGradeChanged,
          title:
              "Vous allez maintenant renseigner l'importance de la sécurité du pays.",
          isAllergy: false,
          criteriaName: "Sécurité du pays"),
      Step(
          onGradeChanged: onGradeChanged,
          title:
              "Vous allez maintenant renseigner l'importance des risques sanitaires du pays.",
          isAllergy: false,
          criteriaName: "Risques sanitaires du pays"),
      Step(
          onGradeChanged: onGradeChanged,
          title:
              "Vous allez maintenant renseigner l'importance du climat sociopolitique du pays.",
          isAllergy: false,
          criteriaName: "Climat sociopolitique du pays"),
      Step(
          onGradeChanged: onGradeChanged,
          title:
              "Vous allez maintenant renseigner l'importance des conséquences liées au changement climatique dans le pays visité.",
          isAllergy: false,
          criteriaName:
              "Conséquences liées au changement climatique dans le pays visité"),
      Step(
          onGradeChanged: onGradeChanged,
          title:
              "Vous allez maintenant renseigner l'importance des us et coutumes du pays.",
          isAllergy: false,
          criteriaName: "Us et coutumes du pays"),
      Step(
          onGradeChanged: onGradeChanged,
          title:
              "Vous allez maintenant renseigner l'importance du respect des droits LGBTQ+.",
          isAllergy: false,
          criteriaName: "Respect des droits LGBTQ+"),
      Step(
          onGradeChanged: onGradeChanged,
          title:
              "Vous allez maintenant renseigner l'importance des allergies alimentaires dans le pays.",
          isAllergy: true,
          criteriaName: "Allergies alimentaires dans le pays"),
    ];

    void showStepperDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            // width: MediaQuery.of(context).size.width * 0.6,
            child: AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                PrimaryButton(
                  onPressed: () {
                    setState(() {
                      if (step > 0) {
                        step--;
                        Navigator.of(context).pop();
                        showStepperDialog();
                      }
                    });
                  },
                  text: "Précédent",
                ),
                StepperIndicator(stepIndex: step),
                PrimaryButton(
                  onPressed: () async {
                    String token =
                        "c29ec1e733d7fd6283fab3b94a18984d95a390b8"; // TODO: fetch the real token

                    Dio dio = Dio();
                    dio.options.headers['content-type'] = "application/json";
                    dio.options.headers['Authorization'] = "Token $token";

                    Map<String, dynamic> body = {
                      "name": steps[step].criteriaName,
                      "grade": grades[step],
                      "types": [] // TODO: will be different for allergy dialog
                    };
                    final response = await dio.post(
                        "$baseUrl/accounts/criteria",
                        data: jsonEncode(body));

                    // if successful
                    if (response.statusCode == 201) {
                      if (step < (steps.length - 1)) {
                        step++;
                        Navigator.of(context).pop();
                        showStepperDialog();
                      } else {
                        Navigator.of(context).pop();

                        Dio dio = Dio();
                        dio.options.headers['Authorization'] = "Token $token";
                        final response = await dio.get("$baseUrl/accounts");
                        if (response.statusCode == 200) {
                          user.user = response.data;
                          // user.token_ = token; // TODO:
                        } else {
                          // TODO: deal with the error (display the message)
                          // print(
                          //     "An error ocurred when trying to retrieve the user");
                        }

                        Navigator.of(context).pushReplacementNamed("/profile");
                      }
                      setState(() {});
                    } else {
                      // print(
                      //     "Une erreur est survenue, merci de remplir vos critères plus tard.");
                      // TODO: find another way to do that
                    }

                    // // else
                  },
                  text: "Suivant",
                )
              ],
              content: SingleChildScrollView(
                  scrollDirection: Axis.vertical, child: steps[step]),
            ),
          );
        },
      );
    }

    void showBaseDialog() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Bienvenue sur TravelSafe !",
                  style: Theme.of(context).textTheme.headlineMedium),
              actions: [
                Center(
                  child: Column(
                    children: [
                      PrimaryButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          showStepperDialog();
                        },
                        text: "Commencer",
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextButton(
                          textColor: const Color(0xFF326B69),
                          onPressed: () => Navigator.of(context).pop(),
                          text: "Remplir plus tard")
                    ],
                  ),
                )
              ],
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                    "Merci d'avoir créé votre compte sur TravelSafe.\nAfin d'optimiser vos recherches de destinatons, nous vous proposons de remplir vos critères de voyage. Ainsi, vous pourrez trouver une destination qui respecte vos contraintes en toute simplicité.",
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
            );
          });
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: showBaseDialog,
            child: Text("Renseigner les critères",
                style: Theme.of(context).textTheme.bodyMedium)),
      ),
    );
  }
}

class Step extends StatefulWidget {
  const Step(
      {super.key,
      required this.title,
      required this.isAllergy,
      required this.criteriaName,
      required this.onGradeChanged});

  final String title;
  final bool isAllergy;
  final String criteriaName;
  final Function(double grade) onGradeChanged;

  @override
  State<Step> createState() => _StepState();
}

class _StepState extends State<Step> {
  int _allergiaCount = 1;
  final List<TextEditingController> _controllers = [TextEditingController()];
  // TODO: determine how to make the request for every controller.

  void _onChanged(double value) {
    widget.onGradeChanged(value);
  }

  // bool _isOneControllerEmpty(List<TextEditingController> controllers) {
  //   for (int i = 0; i <= controllers.length; i++) {
  //     if (controllers[i].text == "") {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  void _addAllergiaType() {
    // if (!_isOneControllerEmpty(_controllers)) {

    // } else {
    //   print("Une allergie ne peut être vide.");
    // }
    setState(() {
      _allergiaCount++;
      _controllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width * 0.4,
      // height: MediaQuery.of(context).size.height * 0.6,
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
                        count: _allergiaCount, controllers: _controllers)
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
                // Text() // FIXME: place the error text here
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
