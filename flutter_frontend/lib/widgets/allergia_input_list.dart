import 'package:flutter/material.dart';

class AllergiaInputList extends StatelessWidget {
  const AllergiaInputList({super.key, required this.controllers});

  final List<TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    return controllers.isNotEmpty
        ? SingleChildScrollView(
            child: SizedBox(
            height: 150,
            width: 600,
            child: ListView.builder(
              itemCount: controllers.length,
              itemBuilder: (context, index) =>
                  TextField(controller: controllers[index]),
              // itemBuilder: (context, index) => TextFieldRemovable(
              //     controller: controllers[
              //         index], // TODO: place the textfields in a form (wrap the listview perhaps)
              //     onDelete: () {}), // TODO: code the onDelete function
            ),
          ))
        : const SizedBox();
  }
}
