import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_frontend/handlers.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/pages/country_page.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({super.key, required this.country});

  final Country country;

  Widget _getCountryLevel() {
    // FIXME: should return an image
    // TODO: case when the value is 0 -> Return smthg ???
    return Text(country.level.toString());
  }

  void _onDownloadCountrySheet() async {
    // bool isMobile = Platform.isAndroid || Platform.isIOS;
    await downloadCountrySheet(country, false);
  }

  void _goToCountry(BuildContext context, int index) {
    // Navigator.of(context).pushNamed("/country");
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CountryPage(countryIndex: index),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _goToCountry(context, country.id),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _getCountryLevel(),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                  width: 100,
                  child: Hero(tag: "countryName", child: Text(country.name)))
            ],
          ),
          SizedBox(
              width: 300,
              child: Text(country.lastEdition.toLocal().toString())),
          IconButton(
              onPressed: _onDownloadCountrySheet,
              icon: const Icon(Icons.download))
        ],
      ),
    );
  }
}
