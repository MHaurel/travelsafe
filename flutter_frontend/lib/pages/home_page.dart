import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/widgets/country_list.dart';
import 'package:flutter_frontend/widgets/search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Country> _countries = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _fetchCountries();

    super.initState();
  }

  void _fetchCountries() async {
    Dio dio = Dio();
    final response = await dio.get("$baseUrl/countries/");

    List<Country> countries = [];
    response.data.forEach((c) => countries.add(Country.fromJson(c)));
    setState(() {
      _countries = countries;
    });
  }

  void _onSearchChanged(String s) {
    print(s);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
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
                  Text("Accueil"),
                  SearchField(
                      onChanged: _onSearchChanged,
                      controller: _searchController),
                  CountryList(countries: _countries)
                ],
              ),
            ),

            // Right col with ads
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
