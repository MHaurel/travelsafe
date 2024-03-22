import 'package:flutter/material.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/custom_icon_button.dart';
import 'package:flutter_frontend/widgets/criteria_list_item.dart';
import 'package:flutter_frontend/widgets/dialogs/home_criteria_dialog.dart';
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

  void onOrderChanged(CriteriaSortType st) {
    setState(() {
      _sort = st;
    });
    // TODO:
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Critères",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
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
                    typeIndex: null),
                CriteriaListItem(
                    criteria: context.watch<UserProvider>().user.criteriaLgbt,
                    typeIndex: null),
                CriteriaListItem(
                    criteria:
                        context.watch<UserProvider>().user.criteriaCustoms,
                    typeIndex: null),
                CriteriaListItem(
                    criteria:
                        context.watch<UserProvider>().user.criteriaClimate,
                    typeIndex: null),
                CriteriaListItem(
                    criteria: context
                        .watch<UserProvider>()
                        .user
                        .criteriaSociopolitical,
                    typeIndex: null),
                CriteriaListItem(
                    criteria:
                        context.watch<UserProvider>().user.criteriaSanitary,
                    typeIndex: null),
                CriteriaListItem(
                    criteria:
                        context.watch<UserProvider>().user.criteriaSecurity,
                    typeIndex: null),
                CriteriaListItem(
                    criteria: context.watch<UserProvider>().user.criteriaFood,
                    typeIndex: null), // TODO: add types
              ],
            ),
          ),
        ),
        CustomIconButton(
            onPressed: () => showDialog(
                context: context,
                builder: (context) => const HomeCriteriaDialog()),
            text: "Ajouter un critère",
            icon: Icons.add)
      ],
    );
  }
}
