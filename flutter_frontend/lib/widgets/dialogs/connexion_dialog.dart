import 'package:flutter/material.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/custom_text_button.dart';
import 'package:flutter_frontend/widgets/connexion.dart';
import 'package:flutter_frontend/widgets/dialogs/signup_dialog.dart';
import 'package:provider/provider.dart';

class ConnexionDialog extends StatefulWidget {
  const ConnexionDialog({super.key});

  @override
  State<ConnexionDialog> createState() => _ConnexionDialogState();
}

class _ConnexionDialogState extends State<ConnexionDialog> {
  String errorMsg = "";

  @override
  Widget build(BuildContext context) {
    TextEditingController mailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    mailController.text = "maximelebest@gmail.com";
    passwordController.text = "admin";

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: AlertDialog(
        surfaceTintColor: Colors.white,
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(alignment: Alignment.topRight, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Connexion",
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
                ConnexionForm(
                    onConnexion: () async {
                      // User user = Provider.of<User>(context);
                      String? loginMessage = await context
                          .read<UserProvider>()
                          .login(mailController.text, passwordController.text);

                      if (loginMessage == null) {
                        setState(() {
                          errorMsg = "";
                        });
                        Navigator.of(context).pop(); // Closing the dialog
                      } else {
                        setState(() {
                          errorMsg = loginMessage;
                        });
                      }
                    },
                    mailController: mailController,
                    passwordController: passwordController),
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
                    text: "Pas de compte?",
                    textColor: Colors.black54,
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (context) => const SignupDialog());
                    })
              ],
            ),
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close))
          ]),
        ),
      ),
    );
  }
}
