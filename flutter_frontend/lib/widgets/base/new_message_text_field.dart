import 'package:flutter/material.dart';

class NewMessageTextField extends StatefulWidget {
  const NewMessageTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.onTap});

  final String hintText;
  final TextEditingController controller;
  final Function() onTap;

  @override
  State<NewMessageTextField> createState() => _NewMessageTextFieldState();
}

class _NewMessageTextFieldState extends State<NewMessageTextField> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Le contenu de votre message ne peut être vide.";
            }
            return null;
          },
          controller: widget.controller,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) widget.onTap();
                },
                child: const Icon(Icons.keyboard_return),
              ), // Icon to be displayed as suffix
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Color(0xFFA8D6AC)),
              ),
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium)),
    );
  }
}
