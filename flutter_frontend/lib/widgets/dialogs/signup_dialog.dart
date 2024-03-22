import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/user.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/custom_text_button.dart';
import 'package:flutter_frontend/widgets/dialogs/connexion_dialog.dart';
import 'package:flutter_frontend/widgets/dialogs/home_criteria_dialog.dart';
import 'package:flutter_frontend/widgets/signup_form.dart';
import 'package:provider/provider.dart';

class SignupDialog extends StatefulWidget {
  const SignupDialog({super.key});

  @override
  State<SignupDialog> createState() => _SignupDialogState();
}

class _SignupDialogState extends State<SignupDialog> {
  String errorMsg = "";

  @override
  Widget build(BuildContext context) {
    TextEditingController lastNameController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController mailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    void onSignup() async {
      String? signupMessage = await context.read<UserProvider>().signup(
          mailController.text,
          passwordController.text,
          firstNameController.text,
          lastNameController.text);

      if (signupMessage == null) {
        setState(() {
          errorMsg = "";
        });

        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/profile");
        showDialog(
            context: context, builder: (context) => const HomeCriteriaDialog());
      } else {
        setState(() {
          errorMsg = signupMessage;
        });
      }
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: AlertDialog(
        surfaceTintColor: Colors.white,
        content: Stack(alignment: Alignment.topRight, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Inscription",
                  style: Theme.of(context).textTheme.headlineMedium),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SignUpForm(
                  onSignup: () {
                    onSignup();
                  },
                  lastNameController: lastNameController,
                  firstNameController: firstNameController,
                  mailController: mailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    errorMsg,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              CustomTextButton(
                  text: "Déjà un compte ?",
                  textColor: Colors.black54,
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => const ConnexionDialog(),
                    );
                  })
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
