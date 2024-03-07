import 'package:flutter/cupertino.dart';

class CriteriaSwitch extends StatefulWidget {
  const CriteriaSwitch({super.key, required this.onChanged});

  final Function(bool b) onChanged;

  @override
  State<CriteriaSwitch> createState() => _CriteriaSwitchState();
}

class _CriteriaSwitchState extends State<CriteriaSwitch> {
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: CupertinoSwitch(
          value: active,
          activeColor: const Color(0xFFA8D6AC),
          onChanged: (e) {
            setState(() {
              active = !active;
            });
            widget.onChanged(e);
          }),
    );
  }
}
