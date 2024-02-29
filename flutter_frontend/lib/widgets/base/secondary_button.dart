import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.onPressed, required this.text});

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: onPressed, style: ButtonStyle(
      side: MaterialStateProperty.all(BorderSide(color: Colors.transparent, width: 1.0, strokeAlign: BorderSide.strokeAlignInside)),
      backgroundColor: MaterialStateProperty.all(const Color(0xFFD7D7D7))
    ), child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(text, style : TextStyle(
        color : const Color(0xFF07020D),
        fontFamily: Theme.of(context).textTheme.bodyMedium!.fontFamily,
        fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
        fontWeight: Theme.of(context).textTheme.bodyMedium!.fontWeight
      )),
      ),);
  }
}
