import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/widgets/country_card.dart';

class CountryList extends StatelessWidget {
  const CountryList({super.key, required this.countries});

  final List<Country> countries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Liste des pays"),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Destination"),
            Text("Dernière mise à jour"),
            SizedBox()
          ],
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: countries.length,
            itemBuilder: (context, index) {
              if (index == (countries.length - 1)) {
                return Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black, width: 1))),
                  child: CountryCard(country: countries[index]),
                );
              }
              return CountryCard(country: countries[index]);
            },
          ),
        )
      ],
    );
  }
}
