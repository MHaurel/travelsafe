import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/user.dart';
import 'package:flutter_frontend/pages/criteria_display.dart';
import 'package:flutter_frontend/pages/profile_display.dart';
import 'package:flutter_frontend/pages/subscriptions_display.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/nav_bar.dart';
import 'package:flutter_frontend/widgets/base/primary_button.dart';
import 'package:flutter_frontend/widgets/base/secondary_button.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _index = 0;
  final List<Widget> _widgetOptions = [
    const ProfileDisplay(),
    const CriteriaDisplay(),
    const SubscriptionsDisplay(),
  ];

  final List<String> _drawerTilesName = [
    'Informations',
    'Critères',
    'Abonnements'
  ];

  @override
  void initState() {
    super.initState();
  }

  void navigateHomeIfUserUndefined(BuildContext context, User user) {
    // FIXME: later, make protected routes
  }

  // !: the function has been written but will be implement in a next version
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
                        style: TextStyle(
                            fontFamily: "Montserrat",
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
      // !: deal with the error (display the message)
      // print("An error ocurred when trying to retrieve the user");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(appBar: AppBar()),
      body: Row(
        children: [
          Drawer(
            shape: Border(
                right: BorderSide(
                    color: Theme.of(context).primaryColor, width: 4)),
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            child: ListView.builder(
              itemCount: _drawerTilesName.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(_drawerTilesName[index]),
                  tileColor: _index == index
                      ? const Color(0xffA8D6AC)
                      : Colors.transparent,
                  onTap: () => setState(() {
                    _index = index;
                  }),
                ),
              ),
              padding: EdgeInsets.zero,
            ),
          ),
          Expanded(
            child: _widgetOptions[_index],
          ),
        ],
      ),
    );
  }
}
