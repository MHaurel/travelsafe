import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/user.dart';
import 'package:flutter_frontend/widgets/base/primary_button.dart';
import 'package:flutter_frontend/widgets/base/secondary_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _navigateHomeIfUserUndefined(BuildContext context, User user) {
    // TODO: protected route: redefine this
    if (user.isUserNull) Navigator.of(context).pushReplacementNamed("/");
  }

  Future<void> _updateUser(User user) async {
    Map<String, dynamic> body = {
      "first_name": user.firstName,
      "last_name": user.lastName,
      "email": user.email
    };

    Dio dio = Dio();
    dio.options.headers["Authorization"] =
        "Token c29ec1e733d7fd6283fab3b94a18984d95a390b8";
    final response =
        await dio.put("$baseUrl/accounts/${user.id}", data: jsonEncode(body));
  }

  Future<void> _login(User user) async {
    String email = "maxime@gkkkk.com";
    String password = "admin";

    Map<String, dynamic> body = {"email": email, "password": password};

    Dio dio = Dio();
    final response = await dio.post("$baseUrl/login", data: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      String token = response.data['token'];
      print("The token is $token");
      bool hasUserBeenRetrieved = await _retrieveUser(user, token);
      if (!hasUserBeenRetrieved) {
        // TODO: deal with the case that the user can't be retrieved
        // print("An error occured when trying to retrieved the user")
      }
    } else {
      // TODO: deal with the error (display the message)
      print("An error ocurred when trying to login");
    }
  }

  Future<bool> _retrieveUser(User user, String token) async {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Token $token";
    final response = await dio.get("$baseUrl/accounts");

    print(response.data);
    if (response.statusCode == 200) {
      // User user = Provider.of<User>(context, listen: false);
      user.user = response.data;
      user.token_ = token;
      return true;
    } else {
      // TODO: deal with the error (display the message)
      print("An error ocurred when trying to retrieve the user");
      return false;
    }
  }

  void _showDeleteDialog(BuildContext context, User user) {
    // TODO: code the function that make a dialog appear to confirm the user deletion and redirects to the home page
    showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: AlertDialog(
              surfaceTintColor: Colors.white,
              content: Stack(alignment: Alignment.topRight, children: [
                Container(
                  child: Column(
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
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontSize,
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
                                bool done = await _deleteUser(user);
                                if (done) {
                                  Navigator.of(context).pop();
                                  user.nullify();
                                  Navigator.pushReplacementNamed(context, "/");
                                }
                              },
                              text: "Valider")
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close))
              ]),
            ),
          );
        });
  }

  Future<bool> _deleteUser(User user) async {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Token ${user.token}";
    final response = await dio.delete("$baseUrl/accounts/${user.id}");

    if (response.statusCode == 204) {
      return true;
    } else {
      // TODO: deal with the error (display the message)
      print("An error ocurred when trying to retrieve the user");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Profile', style: Theme.of(context).textTheme.headlineMedium),
            Text("${user.fullName} - Token: ${user.token}"),
            PrimaryButton(
                onPressed: () => _login(user),
                text: "Se connecter avec un utilisateur prédéfini"),
            PrimaryButton(
                onPressed: () => _updateUser(user),
                text: "Mettre à jour l'utilisateur"),
            SecondaryButton(
                onPressed: () => _showDeleteDialog(context, user),
                text: "Supprimer l'utilisateur")
          ],
        ),
      ),
    );
  }
}
