import 'package:flutter/material.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/primary_button.dart';
import 'package:flutter_frontend/widgets/base/secondary_button.dart';
import 'package:provider/provider.dart';

class UnsubscribeDialog extends StatelessWidget {
  const UnsubscribeDialog({super.key, required this.countryIndex});

  final int countryIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: AlertDialog(
        surfaceTintColor: Colors.white,
        content: Stack(alignment: Alignment.topRight, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Se désabonner",
                  style: Theme.of(context).textTheme.headlineMedium),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                      color: const Color(0xffD7D7D7),
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const Text("Attention ! Vous allez vous désabonner de ce pays."),
              const Text("Êtes-vous sûr de ne plus vouloir suivre ce pays ?"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                      color: const Color(0xffD7D7D7),
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SecondaryButton(
                      onPressed: () => Navigator.of(context).pop(),
                      text: "Annuler"),
                  const SizedBox(
                    width: 16,
                  ),
                  PrimaryButton(
                      onPressed: () {
                        context.read<UserProvider>().unsubscribe(countryIndex);
                        Navigator.of(context).pop();
                      },
                      text: "Valider")
                ],
              )
            ],
          ),
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close))
        ]),
      ),
    );
  }
}
