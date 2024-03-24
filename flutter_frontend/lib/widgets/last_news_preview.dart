import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_frontend/models/last_info.dart';
import 'package:flutter_frontend/widgets/base/custom_error_widget.dart';
import 'package:flutter_frontend/widgets/base/loader.dart';
import 'package:flutter_frontend/widgets/last_info_card_small.dart';

class LastNewsPreview extends StatefulWidget {
  const LastNewsPreview({super.key});

  @override
  State<LastNewsPreview> createState() => _LastNewsPreviewState();
}

class _LastNewsPreviewState extends State<LastNewsPreview> {
  late Future<List<LastInfo>> _lastNews;

  Future<List<LastInfo>> _fetchLastNews() async {
    Dio dio = Dio();
    final response = await dio.get("${dotenv.env['API_BASEPATH']}/news/last");

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
                text: "Une erreur est survenue. Veuillez réessayer plus tard.");
          } else {
            if (snapshot.data!.isEmpty) {
              return const SizedBox(); // There are no last news => return an empty widget
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LastInfoCardSmall(lastInfo: snapshot.data!.first),
                snapshot.data?.last != null
                    ? LastInfoCardSmall(lastInfo: snapshot.data!.last)
                    : const SizedBox(),
              ],
            );
          }
        } else {
          return const Loader();
        }
      },
    );
  }
}
