// import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_frontend/handlers.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/pages/country_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({super.key, required this.country, required this.isLast});

  final Country country;
  final bool isLast;

  void _onDownloadCountrySheet() async {
    // bool isMobile = Platform.isAndroid || Platform.isIOS;
    // await downloadCountrySheet(country, false);
    country.buildPdf(false); // TODO:
  }

  void _goToCountry(BuildContext context, int index) {
    // Navigator.of(context).pushNamed("/country");
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CountryPage(countryIndex: index),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Hero makeImageCountry() {
      return Hero(
        tag: "hero-${country.name}",
        child: SvgPicture.asset(
          "assets/images/RiskLevel${country.level.toString()}.svg",
          width: 24,
          height: 24,
        ),
      );
    }

    return InkWell(
      onTap: () => _goToCountry(context, country.id),
      child: Container(
        decoration: BoxDecoration(
            border: isLast
                ? null
                : const Border(bottom: BorderSide(color: Color(0xffD7D7D7)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                makeImageCountry(),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(width: 100, child: Text(country.name))
              ],
            ),
            SizedBox(width: 300, child: Text(country.properDateCreated)),
            IconButton(
                onPressed: _onDownloadCountrySheet,
                icon: const Icon(Icons.download))
          ],
        ),
      ),
    );
  }
}
