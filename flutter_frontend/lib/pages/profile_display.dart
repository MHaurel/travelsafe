import 'package:flutter/material.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/secondary_button.dart';
import 'package:provider/provider.dart';

class ProfileDisplay extends StatelessWidget {
  const ProfileDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("username is ${context.watch<UserProvider>().user.fullName}"),
        SecondaryButton(
            onPressed: () {
              context.read<UserProvider>().logout();
              Navigator.of(context).pushReplacementNamed("/");
            },
            text: "Se déconnecter")
      ],
    );
  }
}
