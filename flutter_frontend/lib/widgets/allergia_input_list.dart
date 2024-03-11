import 'package:flutter/material.dart';

class AllergiaInputList extends StatelessWidget {
  const AllergiaInputList(
      {super.key, required this.count, required this.controllers});

  final int count;
  final List<TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
      height: 150,
      width: 600,
      child: ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) =>
            TextField(controller: controllers[index]),
        // itemBuilder: (context, index) => TextFieldRemovable(
        //     controller: controllers[
        //         index], // TODO: place the textfields in a form (wrap the listview perhaps)
        //     onDelete: () {}), // TODO: code the onDelete function
      ),
    ));
  }
}
