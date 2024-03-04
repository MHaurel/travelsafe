import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, required this.onPressed, required this.text, required this.icon});

  final Function() onPressed;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: onPressed,style: ButtonStyle(
      side: MaterialStateProperty.all((BorderSide(color: Colors.white, width: 1.0, strokeAlign: BorderSide.strokeAlignCenter))),
      backgroundColor: MaterialStateProperty.all(const Color(0xFF326B69))
    ), child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child:  FittedBox(
        child: Row(
          children: [
            Text(text, style: TextStyle(
              color: Colors.white,
              fontFamily: Theme.of(context).textTheme.bodyMedium!.fontFamily,
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              fontWeight: Theme.of(context).textTheme.bodyMedium!.fontWeight

            )),
            Icon(icon, color: Colors.white,)
          ],
        ),)
      
      ));
      
  }
}