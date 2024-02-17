import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/widgets/country_card.dart';

enum SortType {
  none,
  countryAscending,
  countryDescending,
  lastUpdateAscending,
  lastUpdateDescending
}

class CountryList extends StatefulWidget {
  const CountryList({super.key, required this.countries});

  final List<Country> countries;

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  SortType sort = SortType.none;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Liste des pays"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text("Destination"),
                IconButton(
                    onPressed: () {
                      setState(() {
                        sort = SortType.countryAscending;
                      });
                    },
                    icon: Icon(
                      Icons.arrow_drop_up,
                      color: sort == SortType.countryAscending
                          ? Colors.black
                          : Colors.black.withOpacity(0.2),
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        sort = SortType.countryDescending;
                      });
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: sort == SortType.countryDescending
                          ? Colors.black
                          : Colors.black.withOpacity(0.2),
                    )),
              ],
            ),
            Row(
              children: [
                Text("Dernière mise à jour"),
                IconButton(
                    onPressed: () {
                      setState(() {
                        sort = SortType.lastUpdateAscending;
                      });
                    },
                    icon: Icon(
                      Icons.arrow_drop_up,
                      color: sort == SortType.lastUpdateAscending
                          ? Colors.black
                          : Colors.black.withOpacity(0.2),
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        sort = SortType.lastUpdateDescending;
                      });
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: sort == SortType.lastUpdateDescending
                          ? Colors.black
                          : Colors.black.withOpacity(0.2),
                    )),
              ],
            ),
            SizedBox()
          ],
        ),
        SizedBox(
          height: 600,
          child: ListView.builder(
            itemCount: widget.countries.length,
            itemBuilder: (context, index) {
              if (index != (0)) {
                return Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black, width: 1))),
                  child: CountryCard(country: widget.countries[index]),
                );
              }
              return CountryCard(country: widget.countries[index]);
            },
          ),
        )
      ],
    );
  }
}
