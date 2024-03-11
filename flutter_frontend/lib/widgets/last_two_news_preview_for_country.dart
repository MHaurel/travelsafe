import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/models/last_info.dart';
import 'package:flutter_frontend/widgets/last_info_card_large.dart';
import 'package:flutter_frontend/widgets/last_info_card_small.dart';

class LastTwoNewsPreviewForCountry extends StatefulWidget {
  const LastTwoNewsPreviewForCountry({super.key, required this.country});

  final Country country;

  @override
  State<LastTwoNewsPreviewForCountry> createState() =>
      _LastTwoNewsPreviewForCountryState();
}

class _LastTwoNewsPreviewForCountryState
    extends State<LastTwoNewsPreviewForCountry> {
  late Future<List<LastInfo>> _lastNews;

  Future<List<LastInfo>> _fetchLastNews() async {
    Dio dio = Dio();
    final response = await dio.get(
        "$baseUrl/news/last"); // TODO: change this to match the country passed in parameter

    List<LastInfo> lastNews = [];
    response.data.forEach((ln) => lastNews.add(LastInfo.fromJson(ln)));
    return lastNews;
  }

  @override
  void initState() {
    _lastNews = _fetchLastNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _lastNews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // TODO: re-design the error widget
            return ErrorWidget("Could not fetch countries");
          } else {
            if (snapshot.data!.isEmpty) {
              return SizedBox(); // There are no last news => return an empty widget
            }
            return Column(
              children: [
                Text(
                  "Dernières informations",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LastInfoCardLarge(lastInfo: snapshot.data!.first),
                    snapshot.data?.last != null
                        ? LastInfoCardLarge(lastInfo: snapshot.data!.last)
                        : const SizedBox(),
                  ],
                ),
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
      },
    );
  }
}
