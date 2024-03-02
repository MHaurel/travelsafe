import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/user.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _navigateHomeIfUserUndefined(BuildContext context, User user) {
    // TODO: redefine it
    if (user.isUserNull) Navigator.of(context).pushReplacementNamed("/");
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Profile', style: Theme.of(context).textTheme.headlineMedium),
            Text(user.fullName)
          ],
        ),
      ),
    );
  }
}
