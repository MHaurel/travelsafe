import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      required this.hintText,
      required this.controller,
      required this.keyboardType,
      required this.maxLines});

  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextField(
        maxLines: maxLines ?? 1,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hintText,
            label: Text(label)),
      ),
    );
  }
}
