import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/models/last_info.dart';
import 'package:flutter_frontend/widgets/base/custom_error_widget.dart';
import 'package:flutter_frontend/widgets/base/loader.dart';
import 'package:flutter_frontend/widgets/last_info_card_large.dart';

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
    final response = await dio
        .get("${dotenv.env['API_BASEPATH']}/news/last/${widget.country.id}");

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
            return const CustomErrorWidget(
                text:
                    "Impossible de récupérer les dernières informations pour ce pays.");
          } else {
            if (snapshot.data!.isEmpty) {
              return const SizedBox(); // There are no last news => return an empty widget
            }
            return SizedBox(
              // width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dernières informations",
                    style: TextStyle(
                        fontWeight:
                            Theme.of(context).textTheme.titleMedium!.fontWeight,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                        fontFamily:
                            Theme.of(context).textTheme.titleMedium!.fontFamily,
                        color: const Color(0xff478B85)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LastInfoCardLarge(lastInfo: snapshot.data!.first),
                      snapshot.data!.length > 1
                          ? LastInfoCardLarge(lastInfo: snapshot.data!.last)
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
            );
          }
        } else {
          return const Loader();
        }
      },
    );
  }
}
