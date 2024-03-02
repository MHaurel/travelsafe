import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput(
      {super.key,
      required this.label,
      required this.controller,
      required this.validator});

  final String label;
  final TextEditingController controller;
  final Function(String? value) validator;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _hidden = true;

  void _onToggleVisibility() {
    setState(() {
      _hidden = !_hidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => widget.validator(value),
      controller: widget.controller,
      obscureText: _hidden,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.label,
          suffixIcon: IconButton(
              onPressed: _onToggleVisibility,
              icon: Icon(_hidden ? Icons.visibility : Icons.visibility_off))),
    );
  }
}
