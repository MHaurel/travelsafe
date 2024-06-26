import 'package:flutter/material.dart';

class ReactionDisplay extends StatelessWidget {
  const ReactionDisplay(
      {super.key,
      required this.leading,
      required this.icon,
      required this.onTap});

  final Widget leading;
  final dynamic icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    List<IconData> possibleIcons = [
      Icons.thumb_up,
      Icons.thumb_down,
      Icons.beach_access
    ];

    return Padding(
      padding: const EdgeInsets.only(right: 5.0, top: 10.0),
      child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(128),
              border: Border.all(color: Theme.of(context).primaryColor),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leading,
                  const SizedBox(
                    width: 10,
                  ),
                  icon is int ? Icon(possibleIcons[icon]) : Icon(icon)
                ],
              ),
            ),
          )),
    );
  }
}
