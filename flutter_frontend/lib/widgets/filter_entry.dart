import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilterEntry extends StatefulWidget {
  const FilterEntry(
      {super.key,
      required this.name,
      required this.onChecked,
      required this.controller});

  final String name;
  final Function(bool? b) onChecked;
  final TextEditingController controller;

  @override
  State<FilterEntry> createState() => _FilterEntryState();
}

class _FilterEntryState extends State<FilterEntry> {
  bool _checked = false;

  void _onChecked(bool? newValue) {
    setState(() {
      _checked = newValue ?? false;
    });
    widget.onChecked(_checked);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox.adaptive(value: _checked, onChanged: _onChecked),
        Text(widget.name),
        Row(
          children: [
            const Text("Supérieur ou égal à"),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 60,
              child: TextFormField(
                readOnly: !_checked,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                controller: widget.controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[1-5]$'))
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
