import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.label,
      required this.hintText,
      required this.controller,
      required this.keyboardType,
      required this.validator});

  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String? value) validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextFormField(
        validator: (value) => validator(value),
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hintText,
            label: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
      ),
    );
  }
}
