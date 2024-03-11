import 'package:flutter/material.dart';

class CustomOutlinedIconButton extends StatelessWidget {
  const CustomOutlinedIconButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.icon});

  final Function() onPressed;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            side: MaterialStateProperty.all((const BorderSide(
                color: Color(0xffA8D6AC),
                width: 1.0,
                strokeAlign: BorderSide.strokeAlignCenter)))),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FittedBox(
              child: Row(
                children: [
                  Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Icon(icon, color: Colors.black54)
                ],
              ),
            )));
  }
}
