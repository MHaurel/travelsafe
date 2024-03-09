import 'package:flutter/material.dart';
import 'package:flutter_frontend/widgets/base/custom_text_form_field.dart';
import 'package:flutter_frontend/widgets/base/password_input.dart';
import 'package:flutter_frontend/widgets/base/primary_button.dart';

class ConnexionForm extends StatefulWidget {
  const ConnexionForm(
      {super.key,
      required this.onConnexion,
      required this.mailController,
      required this.passwordController});

  final Function() onConnexion;
  final TextEditingController mailController;
  final TextEditingController passwordController;

  @override
  State<ConnexionForm> createState() => _ConnexionFormState();
}

class _ConnexionFormState extends State<ConnexionForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isEmailValid(String value) {
      String regExp =
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
      return RegExp(regExp).hasMatch(value);
    }

    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: CustomTextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "L'adresse e-mail ne peut être vide";
                  } else if (!isEmailValid(value)) {
                    return "Vous devez entrer une adresse mail valide";
                  }
                  return null;
                },
                controller: widget.mailController,
                keyboardType: TextInputType.emailAddress,
                label: "Mail",
                hintText: "example@example.com",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: PasswordInput(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Le mot de passe ne peut être vide.";
                  }
                },
                controller: widget.passwordController,
                label: "Mot de passe",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimaryButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.onConnexion();
                        }
                      },
                      text: "Se connecter")
                ],
              ),
            ),
          ],
        ));
  }
}
