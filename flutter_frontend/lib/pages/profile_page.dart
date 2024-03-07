import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/user.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/nav_bar.dart';
import 'package:flutter_frontend/widgets/base/primary_button.dart';
import 'package:flutter_frontend/widgets/base/secondary_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void navigateHomeIfUserUndefined(BuildContext context, User user) {
    // TODO: protected route: redefine this
    // if (user.isUserNull) Navigator.of(context).pushReplacementNamed("/");
  }

  Future<void> _updateUser(Dio dio, User user) async {
    Map<String, dynamic> body = {
      "first_name": user.firstName,
      "last_name": user.lastName,
      "email": user.email
    };

    final response =
        await dio.put("/accounts/${user.id}", data: jsonEncode(body));

    if (response.statusCode == 200) {
      // TODO: feedback
    } else {
      // TODO: feedback
    }
  }

  void _showDeleteDialog(BuildContext context, User user) {
    showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: AlertDialog(
              surfaceTintColor: Colors.white,
              content: Stack(alignment: Alignment.topRight, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Suppression du compte",
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
                    Text(
                      "Attention ! Voulez-vous vraiment supprimer votre compte ?",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text("Cette action est irréversible",
                        style: GoogleFonts.montserrat(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize:
                                Theme.of(context).textTheme.bodyLarge!.fontSize,
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: Container(
                        height: 5,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SecondaryButton(
                            onPressed: () => Navigator.of(context).pop(),
                            text: "Annuler"),
                        const SizedBox(width: 16),
                        PrimaryButton(
                            onPressed: () async {
                              bool done = await _deleteUser(
                                  context.watch<UserProvider>().dio, user);
                              if (done) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                                //  TODO: user.nullify();
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacementNamed(context, "/");
                              }
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
        });
  }

  Future<bool> _deleteUser(Dio dio, User user) async {
    // Dio dio = Dio();
    // dio.options.headers["Authorization"] = "Token ${user.accessToken}";
    final response = await dio.delete("/accounts/${user.id}");

    if (response.statusCode == 204) {
      return true;
    } else {
      // TODO: deal with the error (display the message)
      // print("An error ocurred when trying to retrieve the user");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(appBar: AppBar()),
      body: Center(
        child: Column(
          children: [
            Text('Profile', style: Theme.of(context).textTheme.headlineMedium),
            Text(
                "${context.watch<UserProvider>().user.fullName} - Token: ${context.watch<UserProvider>().user.accessToken}"),
          ],
        ),
      ),
    );
  }
}
