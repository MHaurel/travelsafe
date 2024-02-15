import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField(
      {super.key, required this.onChanged, required this.controller});

  final Function(String s) onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * .3,
      child: TextField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "France",
            icon: Icon(Icons.search)),
        controller: controller,
        keyboardType: TextInputType.text,
        onChanged: onChanged,
      ),
    );
  }
}
