import 'package:flutter/material.dart';

class TextFieldRemovable extends StatelessWidget {
  const TextFieldRemovable(
      {super.key, required this.controller, required this.onDelete});

  final TextEditingController controller;
  final Function() onDelete;

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Le nom ne peut être vide.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          TextFormField(
            validator: (value) => validator(value),
            controller: controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Arachides, Crustacés, ...",
                label: Text("Allergie",
                    style: Theme.of(context).textTheme.bodyMedium)),
          ),
          IconButton(onPressed: onDelete, icon: const Icon(Icons.close))
        ],
      ),
    );
  }
}
