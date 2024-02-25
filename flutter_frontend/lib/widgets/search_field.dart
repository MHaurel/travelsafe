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
        style: TextStyle(color: Color(0xFF49454F)),
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "France",
            labelStyle: TextStyle(color: Color(0xFF000000)),
            prefixIcon: Icon(Icons.search, color: Color(0xFF49454F),)),
        controller: controller,
        keyboardType: TextInputType.text,
        onChanged: onChanged,
      ),
    );
  }
}
