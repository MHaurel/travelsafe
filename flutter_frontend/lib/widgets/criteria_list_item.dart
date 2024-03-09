import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/criteria.dart';

class CriteriaListItem extends StatelessWidget {
  const CriteriaListItem(
      {super.key, required this.criteria, required this.typeIndex});

  final Criteria? criteria;
  final int? typeIndex;

  @override
  Widget build(BuildContext context) {
    return criteria == null
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: const Color(0xffA8D6AC), width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Text(criteria!.name),
                    )),
                typeIndex == null
                    ? const SizedBox()
                    : Text(criteria!.types[typeIndex!].name),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: const Color(0xffA8D6AC), width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Text(criteria!.grade.toString()),
                    )),
              ],
            ),
          );
  }
}
