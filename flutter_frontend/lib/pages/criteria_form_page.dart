import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/widgets/allergia_input_list.dart';

class CriteriaFormPage extends StatefulWidget {
  const CriteriaFormPage({super.key});

  @override
  State<CriteriaFormPage> createState() => _CriteriaFormPageState();
}

class _CriteriaFormPageState extends State<CriteriaFormPage> {
  @override
  Widget build(BuildContext context) {
    String? errorText;

    int step = 0;
    List<Step> steps = const [
      Step(
          title:
              "Vous allez maintenant renseigner l'importance du respect des droits des femmes et des enfants.",
          isAllergy: false,
          criteriaName: "Respect du droit des femmes et des enfants"),
      Step(
          title:
              "Vous allez maintenant renseigner l'importance de la sécurité du pays.",
          isAllergy: false,
          criteriaName: "Sécurité du pays"),
      Step(
          title:
              "Vous allez maintenant renseigner l'importance des risques sanitaires du pays.",
          isAllergy: false,
          criteriaName: "Risques sanitaires du pays"),
      Step(
          title:
              "Vous allez maintenant renseigner l'importance du climat sociopolitique du pays.",
          isAllergy: false,
          criteriaName: "Climat sociopolitique du pays"),
      Step(
          title:
              "Vous allez maintenant renseigner l'importance des conséquences liées au changement climatique dans le pays visité.",
          isAllergy: false,
          criteriaName:
              "Conséquences liées au changement climatique dans le pays visité"),
      Step(
          title:
              "Vous allez maintenant renseigner l'importance des us et coutumes du pays.",
          isAllergy: false,
          criteriaName: "Us et coutumes du pays"),
      Step(
          title:
              "Vous allez maintenant renseigner l'importance du respect des droits LGBTQ+.",
          isAllergy: false,
          criteriaName: "Respect des droits LGBTQ+"),
      Step(
          title:
              "Vous allez maintenant renseigner l'importance des allergies alimentaires dans le pays.",
          isAllergy: true,
          criteriaName: "Allergies alimentaires dans le pays"),
    ];

    void _goToNextStep() {}

    void _showStepperDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
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
                StepperIndicator(stepIndex: step),
                ElevatedButton(
                    onPressed: () async {
                      // call the api to update (or to create it)
                      int userId =
                          14; // FIXME: recuperate it dynamically when registration will be done
                      print(steps[step].criteriaName);

                      // Dio dio = Dio();
                      // dio.options.headers['content-type'] = "application/json";
                      // dio.options.headers['Authorization'] =
                      //     "Token c29ec1e733d7fd6283fab3b94a18984d95a390b8";
                      // final response = await dio
                      //     .post("$baseUrl/accounts/criteria", data: {
                      //   "name": steps[step].criteriaName,
                      //   "grade": 1,
                      //   "types": []
                      // }); // FIXME: types is static here, wont work for allergias (also, get the grade properly)

                      // print(response.statusCode);

                      // if successful
                      setState(() {
                        errorText = null;
                        if (step < (steps.length - 1)) {
                          step++;
                          Navigator.of(context).pop();
                          _showStepperDialog();
                        }
                      });

                      // // else
                      // setState(() {
                      //   errorText =
                      //       "Une erreur est survenue, merci de remplir vos critères plus tard.";
                      // });
                    },
                    child: const Text("Suivant"))
              ],
              content: SingleChildScrollView(
                  scrollDirection: Axis.vertical, child: steps[step]),
            ),
          );
        },
      );
    }

    void _showBaseDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Bienvenue sur TravelSafe !"),
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
                          onPressed: () {}, // ! dispose ?
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
  const Step(
      {super.key,
      required this.title,
      required this.isAllergy,
      required this.criteriaName});

  final String title;
  final bool isAllergy;
  final String criteriaName;

  @override
  State<Step> createState() => _StepState();
}

class _StepState extends State<Step> {
  double _value = 3;
  int _allergiaCount = 1;
  List<TextEditingController> _controllers = [TextEditingController()];
  // TODO: determine how to make the request for every controller.

  void _onChanged(double value) {
    setState(() {
      _value = value;
    });
  }

  void _addAllergiaType() {
    // TODO:
    setState(() {
      _controllers.add(TextEditingController());
      _allergiaCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Text(widget.title),
                widget.isAllergy
                    ? AllergiaInputList(
                        count: _allergiaCount, controllers: _controllers)
                    : const SizedBox(),
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
                ),
                widget.isAllergy
                    ? ElevatedButton(
                        onPressed: _addAllergiaType,
                        child: Text("Ajouter une allergie"),
                      )
                    : const SizedBox(),
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
            color: active ? Color(0xFF478B85) : Color(0xFFD7D7D7),
            borderRadius: BorderRadius.circular(80)),
      ),
    );
  }
}
