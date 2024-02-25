import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.text, required this.textColor, required this.onPressed});

  final String text;
  final Color textColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text, style: TextStyle(color: textColor),));
  }
}