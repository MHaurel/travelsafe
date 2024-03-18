import 'package:flutter/material.dart';
import 'dart:math';

class Pub extends StatefulWidget {
  const Pub({super.key});

  @override
  State createState() => _PubState();
}

class _PubState extends State<Pub> {
  final List<String> imageNames = [
    'assets/images/cascade.jpg',
    'assets/images/montagne.jpg',
    'assets/images/images.jpeg',
    'assets/images/lac.jpg',
    'assets/images/palmier.jpg',
  ];

  final List<String> destinations = [
    "A/R Réunion - 1078€",
    "A/R New-York - 750€",
    "A/R Italie - 3€",
    "A/R Dolomites - 220€",
    "A/R Martinique - 178€",
  ];

  bool isHovered = false;
  int randomNumber = 0;
  Color myColor = const Color(0xFFA3A2A4); //couleur de bordure

  @override
  void initState() {
    super.initState();
    randomNumber = Random().nextInt(imageNames.length);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Card(
              elevation: isHovered ? 4.0 : 0.0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: isHovered
                      ? myColor
                      : Colors
                          .transparent, // Bordure grise si survolé, sinon transparente
                  width: 1.0, // Largeur bordure pixel
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageNames[randomNumber],
                  width: 200,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromRGBO(255, 255, 255, 0.6)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(destinations[randomNumber]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
