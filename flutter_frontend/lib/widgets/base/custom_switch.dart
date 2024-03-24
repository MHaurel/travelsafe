import 'package:flutter/cupertino.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch(
      {super.key, required this.onChanged, required this.active});

  final Function(bool b) onChanged;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: CupertinoSwitch(
          value: active,
          activeColor: const Color(0xFFA8D6AC),
          onChanged: (e) {
            onChanged(e);
          }),
    );
  }
}
