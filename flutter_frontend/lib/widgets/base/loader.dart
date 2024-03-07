import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        const SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('Chargement des résultats...',
              style: Theme.of(context).textTheme.bodyLarge),
        ),
      ]),
    );
  }
}
