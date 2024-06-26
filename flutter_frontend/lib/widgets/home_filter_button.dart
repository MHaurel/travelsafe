import 'package:flutter/material.dart';

class HomeFilterButton extends StatelessWidget {
  const HomeFilterButton({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: FittedBox(
        child: OutlinedButton(
            onPressed: onPressed,
            child: Row(
              children: [
                Text("Filtrer", style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.keyboard_arrow_down)
              ],
            )),
      ),
    );
  }
}
