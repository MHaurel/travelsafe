import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/widgets/country_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

enum SortType {
  none,
  countryAscending,
  countryDescending,
  lastUpdateAscending,
  lastUpdateDescending
}

class CountryList extends StatefulWidget {
  const CountryList(
      {super.key, required this.countries, required this.onOrderChanged});

  final List<Country> countries;
  final Function(SortType st) onOrderChanged;

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  SortType sort = SortType.lastUpdateAscending;

  @override
  Widget build(BuildContext context) {
    return widget.countries.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Liste des pays",
                style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.titleMedium!.fontFamily,
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xff575757)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Destination",
                            style: Theme.of(context).textTheme.bodyLarge),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                sort = SortType.countryAscending;
                              });
                              widget.onOrderChanged(sort);
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
                              widget.onOrderChanged(sort);
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
                        Text("Dernière mise à jour",
                            style: Theme.of(context).textTheme.bodyLarge),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                sort = SortType.lastUpdateAscending;
                              });
                              widget.onOrderChanged(sort);
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
                              widget.onOrderChanged(sort);
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: sort == SortType.lastUpdateDescending
                                  ? Colors.black
                                  : Colors.black.withOpacity(0.2),
                            )),
                      ],
                    ),
                    const SizedBox()
                  ],
                ),
              ),
              AnimationLimiter(
                child: ListView.builder(
                  shrinkWrap: true, // ? this solved the issue !
                  itemCount: widget.countries.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                              child: CountryCard(
                            country: widget.countries[index],
                            isLast: index == widget.countries.length - 1,
                          )),
                        ));
                  },
                ),
              )
            ],
          )
        : Text(
            "Malheureusement, aucun pays ne correspond à vos critères.",
            style: Theme.of(context).textTheme.bodyLarge,
          );
  }
}
