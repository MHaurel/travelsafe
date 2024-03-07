import 'package:flutter/material.dart';

class Pubs extends StatelessWidget {
  //final bool _showBorder = false;

  
@override
  Widget build(BuildContext context) {
    return Card(
  //elevation: 4.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
  child: Image.asset(
    'assets/images/cascade.jpg',
    fit: BoxFit.cover,
    )
    );
  }
}