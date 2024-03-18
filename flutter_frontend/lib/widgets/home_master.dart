import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/models/user.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/pub.dart';
import 'package:flutter_frontend/widgets/country_list.dart';
import 'package:flutter_frontend/widgets/criteria_switch.dart';
import 'package:flutter_frontend/widgets/dialogs/dialog_filter.dart';
import 'package:flutter_frontend/widgets/home_filter_button.dart';
import 'package:flutter_frontend/widgets/last_news_preview.dart';
import 'package:flutter_frontend/widgets/search_field.dart';
import 'package:flutter_frontend/widgets/risk_level_legend.dart';
import 'package:provider/provider.dart';

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

  void _onCriteriaSwitchChanged(bool b) {
    if (b) {
      _applyCriterias();
    } else {
      setState(() {
        _visibleCountries = widget.countries;
      });
    }
  }

  void _applyCriterias() {
    List<Country> filteredCountries = widget.countries;

    User user = context.read<UserProvider>().user;

    if (user.criteriaWomenChildren != null) {
      filteredCountries = filteredCountries
          .where((element) =>
              element.riskWomenChildren!.level >=
              user.criteriaWomenChildren!.grade)
          .toList();
    }

    if (user.criteriaLgbt != null) {
      filteredCountries = filteredCountries
          .where(
              (element) => element.riskLgbt!.level >= user.criteriaLgbt!.grade)
          .toList();
    }

    if (user.criteriaCustoms != null) {
      filteredCountries = filteredCountries
          .where((element) =>
              element.riskCustoms!.level >= user.criteriaCustoms!.grade)
          .toList();
    }

    if (user.criteriaClimate != null) {
      filteredCountries = filteredCountries
          .where((element) =>
              element.riskClimate!.level >= user.criteriaClimate!.grade)
          .toList();
    }

    if (user.criteriaSociopolitical != null) {
      filteredCountries = filteredCountries
          .where((element) =>
              element.riskSociopolitical!.level >=
              user.criteriaSociopolitical!.grade)
          .toList();
    }

    if (user.criteriaSanitary != null) {
      filteredCountries = filteredCountries
          .where((element) =>
              element.riskSanitary!.level >= user.criteriaSanitary!.grade)
          .toList();
    }

    if (user.criteriaSecurity != null) {
      filteredCountries = filteredCountries
          .where((element) =>
              element.riskSecurity!.level >= user.criteriaSecurity!.grade)
          .toList();
    }

    if (user.criteriaFood != null) {
      filteredCountries = filteredCountries
          .where(
              (element) => element.riskFood!.level >= user.criteriaFood!.grade)
          .toList();
    }

    setState(() {
      _visibleCountries = filteredCountries;
    });
  }

  void _applyFilters(Map<String, dynamic> filters) {
    List<Country> countries = widget.countries;
    List<Country> filteredCountries = countries;
    if (filters['riskWomenChildren']['filtered']) {
      filteredCountries = filteredCountries.where((element) {
        if (element.riskWomenChildren != null) {
          return element.riskWomenChildren!.level >=
              int.parse(filters['riskWomenChildren']['controller'].text);
        }
        return false;
      }).toList();
    }
    if (filters['riskLgbt']['filtered']) {
      filteredCountries = filteredCountries.where((element) {
        if (element.riskLgbt != null) {
          return element.riskLgbt!.level >=
              int.parse(filters['riskLgbt']['controller'].text);
        }
        return false;
      }).toList();
    }
    if (filters['riskCustoms']['filtered']) {
      filteredCountries = filteredCountries.where((element) {
        if (element.riskCustoms != null) {
          return element.riskCustoms!.level >=
              int.parse(filters['riskCustoms']['controller'].text);
        }
        return false;
      }).toList();
    }
    if (filters['riskClimate']['filtered']) {
      filteredCountries = filteredCountries.where((element) {
        if (element.riskClimate != null) {
          return element.riskClimate!.level >=
              int.parse(filters['riskClimate']['controller'].text);
        }
        return false;
      }).toList();
    }
    if (filters['riskSociopolitical']['filtered']) {
      filteredCountries = filteredCountries.where((element) {
        if (element.riskSociopolitical != null) {
          return element.riskSociopolitical!.level >=
              int.parse(filters['riskSociopolitical']['controller'].text);
        }
        return false;
      }).toList();
    }
    if (filters['riskSanitary']['filtered']) {
      filteredCountries = filteredCountries.where((element) {
        if (element.riskSanitary != null) {
          return element.riskSanitary!.level >=
              int.parse(filters['riskSanitary']['controller'].text);
        }
        return false;
      }).toList();
    }
    if (filters['riskSecurity']['filtered']) {
      filteredCountries = filteredCountries.where((element) {
        if (element.riskSecurity != null) {
          return element.riskSecurity!.level >=
              int.parse(filters['riskSecurity']['controller'].text);
        }
        return false;
      }).toList();
    }
    if (filters['riskFood']['filtered']) {
      filteredCountries = filteredCountries.where((element) {
        if (element.riskFood != null) {
          return element.riskFood!.level >=
              int.parse(filters['riskFood']['controller'].text);
        }
        return false;
      }).toList();
    }
    setState(() {
      _visibleCountries = filteredCountries;
    });
  }

  void _onFilterPressed() {
    showDialog(
        context: context,
        builder: (context) => DialogFilter(
              applyFilters: _applyFilters,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left col with legend
          Padding(
            padding: const EdgeInsets.only(left: 74.0, right: 108.5),
            child: Container(
              alignment: Alignment.topCenter,
              child: const RiskLevelLegend(),
            ),
          ),

          Expanded(
            flex: 6,
            child: SizedBox(
              // width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pubs(),
                  Text("Accueil",
                      style: Theme.of(context).textTheme.headlineMedium),
                  SearchField(
                      onChanged: _onSearchChanged,
                      controller: _searchController),
                  HomeFilterButton(onPressed: _onFilterPressed),
                  Text(
                    "Dernières informations",
                    style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.titleMedium!.fontFamily,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                        fontWeight: FontWeight.bold),
                  ),
                  const LastNewsPreview(),
                  context.watch<UserProvider>().isAtLeastOneCriteriaFilled()
                      ? Row(
                          children: [
                            Text("Utiliser mes critères",
                                style: Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(width: 30),
                            CriteriaSwitch(onChanged: _onCriteriaSwitchChanged)
                          ],
                        )
                      : const SizedBox(),
                  CountryList(
                      countries: _visibleCountries,
                      onOrderChanged: _onOrderChanged)
                ],
              ),
            ),
          ),

          // Right col with ads
          Padding(
            padding: const EdgeInsets.only(left: 62.5, right: 42),
            child: Container(
              alignment: Alignment.topCenter,
              child: const Column(
                children: [
                  Pub(),
                  Pub(),
                  Pub(),
                ],
              ),
            ),
          ),
          // const Expanded(
          //   flex: 2,
          //   child: Text("droite"),
          //   // child: SizedBox(
          //   //   // width: MediaQuery.of(context).size.width * 0.2,
          //   //   height: double.infinity,
          //   // ),
          // )
        ],
      ),
    );
  }
}
