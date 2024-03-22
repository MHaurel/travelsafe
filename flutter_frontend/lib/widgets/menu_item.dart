import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.onPressed, required this.text});

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: MaterialStateProperty.all(const BorderSide(
          color: Colors.transparent,
          width: 1.0,
          strokeAlign: BorderSide.strokeAlignInside,
        )),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
              color: const Color(0xFF07020D),
              fontFamily: Theme.of(context).textTheme.bodyMedium!.fontFamily,
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              fontWeight: Theme.of(context).textTheme.bodyMedium!.fontWeight,
            ),
            textAlign: TextAlign.left, // align text to the left of the button
          ),
        ),
      ),
    );
  }
}
