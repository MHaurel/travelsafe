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
    return Switch(
        value: active,
        onChanged: (e) {
          setState(() {
            active = !active;
          });
          widget.onChanged(e);
        });
  }
}
