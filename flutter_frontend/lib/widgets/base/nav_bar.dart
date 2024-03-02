import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/user.dart';
import 'package:flutter_frontend/widgets/base/custom_text_button.dart';
import 'package:flutter_frontend/widgets/base/custom_text_field.dart';
import 'package:flutter_frontend/widgets/base/password_input.dart';
import 'package:flutter_frontend/widgets/base/primary_button.dart';
import 'package:flutter_frontend/widgets/signup_form.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const NavBar({super.key, required this.appBar});

  void _onAvatarTapped(BuildContext context, User user) {
    // If the user is not defined : trigger the registering modal, else navigate to profile
    user.isUserNull ? _showRegisterModal(context) : _goToProfile(context);
  }

  void _goToProfile(BuildContext context) {
    Navigator.of(context).pushNamed("/profile");
  }

  void _goToHome(BuildContext context) {
    Navigator.of(context).pushNamed("/");
  }

  void _goToLastInfo(BuildContext context) {
    Navigator.of(context).pushNamed("/news");
  }

  void _onPressed() {}

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return AppBar(
      leadingWidth: 200,
      leading: Padding(
        padding: const EdgeInsets.only(left: 64.0),
        child: Image.asset("assets/images/navbar_logo_2x.png"),
      ),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: (16.0)),
            child: CustomTextButton(
                text: "Accueil",
                textColor: Color(0xFF07020D),
                onPressed: () => _goToHome(context)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: (16.0)),
            child: CustomTextButton(
                text: "Dernières Informations",
                textColor: Color(0xFF07020D),
                onPressed: () => _goToLastInfo(context)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: (16.0)),
            child: CustomTextButton(
                text: "Contact",
                textColor: Color(0xFF07020D),
                onPressed: _onPressed),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: (16.0)),
            child: CustomTextButton(
                text: "Aide",
                textColor: Color(0xFF07020D),
                onPressed: _onPressed),
          ),
        ],
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 64.0),
            child: InkWell(
                onTap: () => _onAvatarTapped(context, user),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(3.5),
                        child: CircleAvatar(
                          child: Icon(
                            Icons.person_rounded,
                            color: Color(0xFFFFFFFF),
                          ),
                          backgroundColor: Color(0xFF326B69),
                          foregroundColor: Color(0xFFFFFFFF),
                        ),
                      )),
                )))
      ],
      backgroundColor: Color(0xFFA8D6AC),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);

  void _showRegisterModal(BuildContext context) {
    TextEditingController _lastNameController = TextEditingController();
    TextEditingController _firstNameController = TextEditingController();
    TextEditingController _mailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();

    void _onSignup(BuildContext context) async {
      Map<String, dynamic> params = {
        "first_name": _firstNameController.text,
        "last_name": _lastNameController.text,
        "email": _mailController.text,
        "password": _passwordController.text,
      };

      Dio dio = Dio();
      final response =
          await dio.post("$baseUrl/accounts", data: jsonEncode(params));
      final data = response.data;

      if (response.statusCode == 201) {
        // update the user provider from the data obtained
        User user = Provider.of<User>(context,
            listen: false); // ? listen: false solved the issue
        user.user = data;

        // Navigate to profile FIXME: show criteria filling modal
        _goToProfile(context);
      } else {
        // TODO: Manage cases (account already exists, no connection, ...)
        print("An error happened when trying so register the user.");
      }
    }

    void _displayLogin() {
      print("Asking to login...");
      // TODO:
      // close this popup
      // show login dialog
    }

    // Shows the modal for the user to signup

    // TODO: add the cross at the top right hand corner
    showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width *
                0.4, // FIXME: check if this works
            child: AlertDialog(
              surfaceTintColor: Colors.white,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  // TODO: create a form widget
                  SignUpForm(
                      onSignup: () => _onSignup(context),
                      lastNameController: _lastNameController,
                      firstNameController: _firstNameController,
                      mailController: _mailController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController),

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
                      onPressed: _displayLogin)
                ],
              ),
            ),
          );
        });
  }
}
