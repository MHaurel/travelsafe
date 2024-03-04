import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_frontend/widgets/base/custom_text_button.dart';
import 'package:flutter_frontend/widgets/base/primary_button.dart';
import 'package:flutter_frontend/widgets/filter_entry.dart';

class DialogFilter extends StatefulWidget {
  const DialogFilter({super.key, required this.applyFilters});

  final Function(List<Map<String, dynamic>> filters) applyFilters;

  @override
  State<DialogFilter> createState() => _DialogFilterState();
}

class _DialogFilterState extends State<DialogFilter> {
  final List<Map<String, dynamic>> _filters = [
    {
      "name": "riskWomenChildren",
      "label": "Importance du respect des droits des femmes et des enfants",
      "filtered": false,
      "controller": TextEditingController()
    },
    {
      "name": "riskLgbt",
      "label": "Importance du respect des droits LGBTQ+",
      "filtered": false,
      "controller": TextEditingController()
    },
    {
      "name": "riskCustoms",
      "label": "Importance des us et coutumes du pays",
      "filtered": false,
      "controller": TextEditingController()
    },
    {
      "name": "riskClimate",
      "label":
          "Importance des conséquences liées au changement climatique dans le pays",
      "filtered": false,
      "controller": TextEditingController()
    },
    {
      "name": "riskSociopolitical",
      "label": "Importance du climat sociopolitique du pays",
      "filtered": false,
      "controller": TextEditingController()
    },
    {
      "name": "riskSanitary",
      "label": "Importance des risques sanitaires du pays",
      "filtered": false,
      "controller": TextEditingController()
    },
    {
      "name": "riskSecurity",
      "label": "Importance de la sécurité du pays",
      "filtered": false,
      "controller": TextEditingController()
    },
    {
      "name": "riskFood",
      "label": "Importance des risques alimentaires",
      "filtered": false,
      "controller": TextEditingController()
    },
  ];

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
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: FilterEntry(
                        name: _filters[index]['label'],
                        onChecked: (b) => _filters[index]['filtered'] = b,
                        controller: _filters[index]['controller']),
                  ),
                ),
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
