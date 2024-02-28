import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.onPressed, required this.text});

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return  OutlinedButton(onPressed: onPressed, style:  ButtonStyle(
      side: MaterialStateProperty.all(BorderSide(color: Colors.transparent, width: 1.0, strokeAlign: BorderSide.strokeAlignInside)),
      backgroundColor: MaterialStateProperty.all(const Color(0xFFA8D6AC)),
    
    ), child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(text, style:  const TextStyle( color: Color(0xFF07020D))),
    ),);
  }
}