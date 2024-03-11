import 'package:flutter/material.dart';
import 'dart:math';

class Pubs extends StatefulWidget {
  @override
  _PubsState createState() => _PubsState();
}

class _PubsState extends State<Pubs> {
    final List<String> imageNames = [
    'assets/images/cascade.jpg',
    'assets/images/montagne.jpg',
    'assets/images/images.jpeg',
    'assets/images/lac.jpg',
    'assets/images/palmier.jpg',
  ];
  
 bool isHovered = false;
 int randomNumber = 0;
 Color myColor = Color(0xFFA3A2A4); //couleur de bordure 

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
      child: Card(
        elevation: isHovered ? 4.0 : 0.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isHovered ? myColor : Colors.transparent, // Bordure grise si survolé, sinon transparente
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
    )
  ),
    );
  }
}