import 'package:flutter/material.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/custom_icon_button.dart';
import 'package:flutter_frontend/widgets/base/custom_text_form_field.dart';
import 'package:flutter_frontend/widgets/base/secondary_button.dart';
import 'package:provider/provider.dart';

class ProfileDisplay extends StatefulWidget {
  const ProfileDisplay({super.key});

  // final User? user;

  @override
  State<ProfileDisplay> createState() => _ProfileDisplayState();
}

class _ProfileDisplayState extends State<ProfileDisplay> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<UserProvider>().isSignedIn()) {
      lastNameController.text = context.watch<UserProvider>().user.lastName!;
      firstNameController.text = context.watch<UserProvider>().user.firstName!;
      mailController.text = context.watch<UserProvider>().user.email!;
    }

    void _onEditInformation() {
      if (_formKey.currentState!.validate()) {
        if (lastNameController.text ==
                Provider.of<UserProvider>(context, listen: false)
                    .user
                    .lastName! &&
            firstNameController.text ==
                Provider.of<UserProvider>(context, listen: false)
                    .user
                    .firstName! &&
            mailController.text ==
                Provider.of<UserProvider>(context, listen: false).user.email!) {
          // User has not edited anything
        } else {
          Map<String, dynamic> body = {
            "first_name": firstNameController.text,
            "last_name": lastNameController.text,
            "email": mailController.text
          };
          Provider.of<UserProvider>(context, listen: false).updateUser(body);
        }
      }
    }

    String? validator(value) {
      if (value == null || value.isEmpty) {
        return "Le champ ne peut être vide.";
      }
      return null;
    }

    bool isEmailValid(String value) {
      String regExp =
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
      return RegExp(regExp).hasMatch(value);
    }

    String? mailValidator(value) {
      if (value == null || value.isEmpty) {
        return "L'adresse e-mail ne peut être vide";
      } else if (!isEmailValid(value)) {
        return "Veuillez entrer une adresse mail valide";
      }
      return null;
    }

    return context.watch<UserProvider>().isSignedIn()
        ? SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              children: [
                Text("Profil",
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(
                  height: 16,
                ),
                Image.asset(
                  "assets/images/avatar.png",
                ),
                const SizedBox(
                  height: 16,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                          label: "Nom",
                          hintText: "",
                          controller: lastNameController,
                          keyboardType: TextInputType.text,
                          validator: validator),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextFormField(
                          label: "Prénom",
                          hintText: "",
                          controller: firstNameController,
                          keyboardType: TextInputType.text,
                          validator: validator),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextFormField(
                          label: "Mail",
                          hintText: "",
                          controller: mailController,
                          keyboardType: TextInputType.text,
                          validator: mailValidator),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SecondaryButton(
                        onPressed: () {
                          context.read<UserProvider>().logout();
                          Navigator.of(context).pushReplacementNamed("/");
                        },
                        text: "Se déconnecter"),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomIconButton(
                        onPressed: _onEditInformation,
                        text: "Valider les modifications",
                        icon: Icons.edit)
                  ],
                )
              ],
            ),
          )
        : const Center(child: Text("Vous n'êtes pas connectés"));
  }
}
