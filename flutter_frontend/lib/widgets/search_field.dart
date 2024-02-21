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
      child: TextFormField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "France",
            prefixIcon: Icon(Icons.search)),
        controller: controller,
        keyboardType: TextInputType.text,
        onChanged: onChanged,
      ),
    );
  }
}
