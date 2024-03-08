import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/criteria.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/country_list.dart';
import 'package:provider/provider.dart';

enum CriteriaSortType {
  none,
  typeAscending,
  typeDescending,
  nameAscending,
  nameDescending,
  levelAscending,
  levelDescending
}

class CriteriaDisplay extends StatefulWidget {
  const CriteriaDisplay({super.key});

  @override
  State<CriteriaDisplay> createState() => _CriteriaDisplayState();
}

class _CriteriaDisplayState extends State<CriteriaDisplay> {
  CriteriaSortType _sort = CriteriaSortType.none;

  void onOrderChanged(CriteriaSortType sort) {
    setState(() {
      _sort = sort;
    });
    // TODO: update the sort
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Critères"),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32.0),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Nom",
                            style: Theme.of(context).textTheme.bodyLarge),
                        IconButton(
                            onPressed: () {
                              onOrderChanged(CriteriaSortType.nameAscending);
                            },
                            icon: Icon(
                              Icons.arrow_drop_up,
                              color: _sort == CriteriaSortType.nameAscending
                                  ? Colors.black
                                  : Colors.black.withOpacity(0.2),
                            )),
                        IconButton(
                            onPressed: () {
                              onOrderChanged(CriteriaSortType.nameDescending);
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: _sort == CriteriaSortType.nameDescending
                                  ? Colors.black
                                  : Colors.black.withOpacity(0.2),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Type",
                            style: Theme.of(context).textTheme.bodyLarge),
                        IconButton(
                            onPressed: () {
                              onOrderChanged(CriteriaSortType.typeAscending);
                            },
                            icon: Icon(
                              Icons.arrow_drop_up,
                              color: _sort == CriteriaSortType.typeAscending
                                  ? Colors.black
                                  : Colors.black.withOpacity(0.2),
                            )),
                        IconButton(
                            onPressed: () {
                              onOrderChanged(CriteriaSortType.typeDescending);
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: _sort == CriteriaSortType.typeDescending
                                  ? Colors.black
                                  : Colors.black.withOpacity(0.2),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Importance",
                            style: Theme.of(context).textTheme.bodyLarge),
                        IconButton(
                            onPressed: () {
                              onOrderChanged(CriteriaSortType.levelAscending);
                            },
                            icon: Icon(
                              Icons.arrow_drop_up,
                              color: _sort == CriteriaSortType.levelAscending
                                  ? Colors.black
                                  : Colors.black.withOpacity(0.2),
                            )),
                        IconButton(
                            onPressed: () {
                              onOrderChanged(CriteriaSortType.levelDescending);
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: _sort == CriteriaSortType.levelDescending
                                  ? Colors.black
                                  : Colors.black.withOpacity(0.2),
                            )),
                      ],
                    ),
                  ],
                ),
                CriteriaListItem(
                    criteria: context
                        .watch<UserProvider>()
                        .user
                        .criteriaWomenChildren,
                    typeIndex: null)
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CriteriaListItem extends StatelessWidget {
  const CriteriaListItem(
      {super.key, required this.criteria, required this.typeIndex});

  final Criteria? criteria;
  final int? typeIndex;

  @override
  Widget build(BuildContext context) {
    return criteria == null
        ? const SizedBox()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xffA8D6AC), width: 2)),
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
                      border: Border.all(color: Color(0xffA8D6AC), width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Text(criteria!.grade.toString()),
                  )),
            ],
          );
  }
}
