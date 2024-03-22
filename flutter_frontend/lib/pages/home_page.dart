import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/widgets/base/custom_error_widget.dart';
import 'package:flutter_frontend/widgets/base/loader.dart';
import 'package:flutter_frontend/widgets/base/nav_bar.dart';
import 'package:flutter_frontend/widgets/home_master.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Country>> _visibleCountries;

  @override
  void initState() {
    _visibleCountries = _fetchCountries();

    super.initState();
  }

  Future<List<Country>> _fetchCountries() async {
    Dio dio = Dio();
    final response = await dio.get("${dotenv.env['API_BASEPATH']}/countries/");

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
                  return const CustomErrorWidget(
                      text:
                          "Une erreur est survenue lorsque nous avons essayé d'afficher les informations. Veuillez réessayer plus tard");
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
