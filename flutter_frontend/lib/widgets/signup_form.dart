import 'package:flutter/material.dart';
import 'package:flutter_frontend/widgets/base/custom_text_form_field.dart';
import 'package:flutter_frontend/widgets/base/password_input.dart';
import 'package:flutter_frontend/widgets/base/primary_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm(
      {super.key,
      required this.onSignup,
      required this.lastNameController,
      required this.firstNameController,
      required this.mailController,
      required this.passwordController,
      required this.confirmPasswordController});

  final Function() onSignup;
  final TextEditingController lastNameController;
  final TextEditingController firstNameController;
  final TextEditingController mailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
                    return "Le nom ne peut être vide.";
                  }
                  return null;
                },
                controller: widget.lastNameController,
                keyboardType: TextInputType.name,
                label: "Nom",
                hintText: "Belle",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: CustomTextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Le prénom ne peut être vide";
                  }
                  return null;
                },
                controller: widget.firstNameController,
                keyboardType: TextInputType.name,
                label: "Prénom",
                hintText: "Anna",
              ),
            ),
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
                  } else if (value != widget.confirmPasswordController.text &&
                      (widget.confirmPasswordController.text.isNotEmpty)) {
                    return "Les mots de passe doivent correspondre.";
                  }
                  return null;
                },
                controller: widget.passwordController,
                label: "Mot de passe",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: PasswordInput(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Le mot de passe de confirmation ne peut être vide.";
                  } else if (value != widget.passwordController.text &&
                      (widget.passwordController.text.isNotEmpty)) {
                    return "Les mots de passe doivent correspondre.";
                  }
                  return null;
                },
                controller: widget.confirmPasswordController,
                label: "Confirmation du mot de passe",
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
                          widget.onSignup();
                        }
                      },
                      text: "S'inscrire")
                ],
              ),
            ),
          ],
        ));
  }
}
