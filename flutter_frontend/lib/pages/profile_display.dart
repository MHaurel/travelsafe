import 'package:flutter/material.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileDisplay extends StatelessWidget {
  const ProfileDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            Text("username is ${context.watch<UserProvider>().user.fullName}"));
  }
}
