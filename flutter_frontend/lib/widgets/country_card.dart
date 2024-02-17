import 'package:flutter/material.dart';
import 'package:flutter_frontend/handlers.dart';
import 'package:flutter_frontend/models/country.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({super.key, required this.country});

  final Country country;

  Widget _getCountryLevel() {
    // FIXME: should return an image
    // TODO: case when the value is 0 -> Return smthg ???
    return Text(country.level.toString());
  }

  void _onDownloadCountrySheet() async {
    print("Asking to download country sheet");
    // TODO: obtain the proper way to pass the isMobile parameter
    await downloadCountrySheet(country, false);
  }

  void _goToCountry() {
    // TODO: push to named route
    print("Asking to go to country $country");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _goToCountry,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _getCountryLevel(),
              const SizedBox(
                width: 20,
              ),
              SizedBox(width: 100, child: Text(country.name))
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
