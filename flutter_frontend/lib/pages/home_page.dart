import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/widgets/base/loader.dart';
import 'package:flutter_frontend/widgets/base/nav_bar.dart';
import 'package:flutter_frontend/widgets/country_list.dart';
import 'package:flutter_frontend/widgets/criteria_switch.dart';
import 'package:flutter_frontend/widgets/home_master.dart';
import 'package:flutter_frontend/widgets/search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Country> _countries = [];
  late Future<List<Country>> _visibleCountries;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _visibleCountries = _fetchCountries().then((value) => _countries = value);

    super.initState();
  }

  Future<List<Country>> _fetchCountries() async {
    Dio dio = Dio();
    final response = await dio.get("$baseUrl/countries/");

    List<Country> countries = [];
    response.data.forEach((c) => countries.add(Country.fromJson(c)));

    return countries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        appBar: AppBar(),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _visibleCountries,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  // TODO: re-design the error widget
                  return ErrorWidget("Could not fetch countries");
                } else {
                  return HomeMaster(countries: snapshot.data!);
                }
              } else {
                return const Loader();
              }
            },
          )),
    );
  }
}
