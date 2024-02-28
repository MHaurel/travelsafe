import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key, required this.onChanged});

  final Function(double v) onChanged;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 3;
  List<String> tooltips = [
    "Pas important", "Peu important", "Neutre", "Important", "Très important", 
  ];
  
  @override
  Widget build(BuildContext context) {
    return Slider(label: tooltips[(_value - 1) as int], divisions: 4, min: 1, max: 5, value: _value, onChanged: (v) {
      widget.onChanged(v);
      setState(() {
        _value = v;
      });
      
    });
  }
}