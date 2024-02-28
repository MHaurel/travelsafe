import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/widgets/collaborative_space.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key, required this.countryIndex});

  final int countryIndex;

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  late int _countryIndex;
  late Future<Country> _country;

  @override
  void initState() {
    _country = _fetchCountry();

    super.initState();
  }

  Future<Country> _fetchCountry() async {
    Dio dio = Dio();
    // TODO: switch to named route
    final response = await dio.get("$baseUrl/country/${widget.countryIndex}/");

    Country country = Country.fromJson(response.data);
    return country;
  }

  @override
  Widget build(BuildContext context) {
    // _countryIndex = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8),
      child: FutureBuilder(
          future: _country,
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // TODO: re-design the error widget
                return ErrorWidget(
                    "Could not fetch country with index: ${widget.countryIndex}");
              } else {
                return Column(
                  children: [
                    Text("Country: ${snapshot.data!.name}"),
                    CollaborativeSpace(
                      countryIndex: snapshot.data!.id,
                    )
                  ],
                );
              }
            } else {
              return const Center(
                child: Column(children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  ),
                ]),
              );
            }
          })),
    ));
  }
}
