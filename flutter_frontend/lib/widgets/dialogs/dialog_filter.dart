import 'package:flutter/material.dart';
import 'package:flutter_frontend/widgets/base/primary_button.dart';
import 'package:flutter_frontend/widgets/filter_entry.dart';

class DialogFilter extends StatefulWidget {
  const DialogFilter({super.key, required this.applyFilters});

  final Function(Map<String, dynamic> filters) applyFilters;

  @override
  State<DialogFilter> createState() => _DialogFilterState();
}

class _DialogFilterState extends State<DialogFilter> {
  final Map<String, dynamic> _filters = {
    "riskWomenChildren": {
      "label": "Importance du respect des droits des femmes et des enfants",
      "filtered": false,
      "controller": TextEditingController()
    },
    "riskLgbt": {
      "label": "Importance du respect des droits LGBTQ+",
      "filtered": false,
      "controller": TextEditingController()
    },
    "riskCustoms": {
      "label": "Importance des us et coutumes du pays",
      "filtered": false,
      "controller": TextEditingController()
    },
    "riskClimate": {
      "label":
          "Importance des conséquences liées au changement climatique dans le pays",
      "filtered": false,
      "controller": TextEditingController()
    },
    "riskSociopolitical": {
      "label": "Importance du climat sociopolitique du pays",
      "filtered": false,
      "controller": TextEditingController()
    },
    "riskSanitary": {
      "label": "Importance des risques sanitaires du pays",
      "filtered": false,
      "controller": TextEditingController()
    },
    "riskSecurity": {
      "label": "Importance de la sécurité du pays",
      "filtered": false,
      "controller": TextEditingController()
    },
    "riskFood": {
      "label": "Importance des risques alimentaires",
      "filtered": false,
      "controller": TextEditingController()
    },
  };

  void _filterCountries() {
    widget.applyFilters(_filters);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(alignment: Alignment.topRight, children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Filtrer",
                    style: Theme.of(context).textTheme.headlineMedium),
                Text(
                    "Sélectionnez les filtres que vous souhaitez appliquer à la liste des pays.",
                    style: Theme.of(context).textTheme.bodyMedium),
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _filters.length,
                    itemBuilder: (context, index) {
                      String key = _filters.keys.toList()[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: FilterEntry(
                            name: _filters[key]['label'],
                            onChecked: (b) => _filters[key]['filtered'] = b,
                            controller: _filters[key]['controller']),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PrimaryButton(
                          onPressed: () {
                            _filterCountries();
                            Navigator.of(context).pop();
                          },
                          text: "Valider")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close))
      ]),
    );
  }
}
