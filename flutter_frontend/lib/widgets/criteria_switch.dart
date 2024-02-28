import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CriteriaSwitch extends StatefulWidget {
  const CriteriaSwitch({super.key, required this.onChanged});

  final Function(bool a) onChanged;

  @override
  State<CriteriaSwitch> createState() => _CriteriaSwitchState();
}

class _CriteriaSwitchState extends State<CriteriaSwitch> {
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
        value: active,
        activeColor: Color(0xFFA8D6AC),
        onChanged: (e) {
          setState(() {
            active = !active;
          });
          widget.onChanged(e);
          
        });
        
  }
}
