import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/widgets/country_list.dart';
import 'package:flutter_frontend/widgets/criteria_switch.dart';
import 'package:flutter_frontend/widgets/home_filter_button.dart';
import 'package:flutter_frontend/widgets/search_field.dart';

class HomeMaster extends StatefulWidget {
  const HomeMaster({
    super.key,
    required this.countries,
  });

  final List<Country> countries;

  @override
  State<HomeMaster> createState() => _HomeMasterState();
}

class _HomeMasterState extends State<HomeMaster> {
  List<Country> _visibleCountries = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _visibleCountries = widget.countries;

    super.initState();
  }

  void _onSearchChanged(String s) {
    List<Country> searchCountries = widget.countries
        .where((e) => e.name.toLowerCase().contains(s.toLowerCase()))
        .toList();
    setState(() {
      _visibleCountries = searchCountries;
    });
  }

  void _onOrderChanged(SortType st) {
    late List<Country> sortedCountries;
    switch (st) {
      case SortType.countryAscending:
        sortedCountries = widget.countries;
        sortedCountries.sort((a, b) => a.name.compareTo(b.name));

      case SortType.countryDescending:
        sortedCountries = widget.countries;
        sortedCountries.sort((a, b) => b.name.compareTo(a.name));

      case SortType.lastUpdateAscending:
        sortedCountries = widget.countries;
        sortedCountries.sort((a, b) => a.lastEdition.compareTo(b.lastEdition));

      case SortType.lastUpdateDescending:
        sortedCountries = widget.countries;
        sortedCountries.sort((a, b) => b.lastEdition.compareTo(a.lastEdition));

      default:
        sortedCountries = widget.countries;
    }

    setState(() {
      _visibleCountries = sortedCountries;
    });
  }

  void _onFilterPressed() {
    // TODO:
    print("Filter pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left col with legend
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          height: double.infinity,
        ),

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Accueil"),
              SearchField(
                  onChanged: _onSearchChanged, controller: _searchController),
              HomeFilterButton(onPressed: _onFilterPressed),
              const Text("Dernières informations"),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dernière information 1"),
                  Text("Dernière information 2"),
                ],
              ),
              Row(
                children: [
                  const Text("Utiliser mes critères"),
                  const SizedBox(width: 30),
                  CriteriaSwitch(onChanged: ((a) => print(a)))
                ],
              ),
              CountryList(
                  countries: _visibleCountries, onOrderChanged: _onOrderChanged)
            ],
          ),
        ),

        // Right col with ads
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          height: double.infinity,
        )
      ],
    );
  }
}
