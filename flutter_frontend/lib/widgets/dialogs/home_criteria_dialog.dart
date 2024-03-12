import 'package:flutter/material.dart';
import 'package:flutter_frontend/widgets/base/custom_text_button.dart';
import 'package:flutter_frontend/widgets/base/primary_button.dart';
import 'package:flutter_frontend/widgets/dialogs/fill_criteria_dialog.dart';

class HomeCriteriaDialog extends StatelessWidget {
  const HomeCriteriaDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
                  showDialog(
                      context: context,
                      builder: (context) => const FillCriteriaDialog());
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
    ;
  }
}
