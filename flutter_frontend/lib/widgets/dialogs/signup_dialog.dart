import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/user.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/custom_text_button.dart';
import 'package:flutter_frontend/widgets/dialogs/connexion_dialog.dart';
import 'package:flutter_frontend/widgets/signup_form.dart';
import 'package:provider/provider.dart';

class SignupDialog extends StatefulWidget {
  const SignupDialog({super.key});

  @override
  State<SignupDialog> createState() => _SignupDialogState();
}

class _SignupDialogState extends State<SignupDialog> {
  @override
  Widget build(BuildContext context) {
    TextEditingController lastNameController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController mailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    TextEditingController errorController = TextEditingController();

    void onSignup() async {
      Map<String, dynamic> params = {
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "email": mailController.text,
        "password": passwordController.text,
      };

      Dio dio = Provider.of<UserProvider>(context, listen: false).dio;
      final response =
          await dio.post("/accounts/create", data: jsonEncode(params));
      final data = response.data;

      if (response.statusCode == 201) {
        // update the user provider from the data obtained
        Provider.of<UserProvider>(context, listen: false).user =
            User.fromJson(data);

        Provider.of<UserProvider>(context, listen: false)
            .login(mailController.text, passwordController.text);

        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/profile");
        // TODO: get tokens
        // TODO: show dialog
      } else {
        // TODO: Manage cases (account already exists, no connection, ...)
        // print("An error happened when trying so register the user.");
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
                    // User user = Provider.of<User>(context);

                    onSignup();
                  },
                  lastNameController: lastNameController,
                  firstNameController: firstNameController,
                  mailController: mailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController),
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
