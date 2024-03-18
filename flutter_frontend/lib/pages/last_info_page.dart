import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/last_info.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/custom_error_widget.dart';
import 'package:flutter_frontend/widgets/base/loader.dart';
import 'package:flutter_frontend/widgets/base/nav_bar.dart';
import 'package:flutter_frontend/widgets/criteria_switch.dart';
import 'package:flutter_frontend/widgets/last_info_list.dart';
import 'package:provider/provider.dart';

class LastInfoPage extends StatefulWidget {
  const LastInfoPage({super.key});

  @override
  State<LastInfoPage> createState() => _LastInfoPageState();
}

class _LastInfoPageState extends State<LastInfoPage> {
  late Future<List<LastInfo>> _lastInfos;
  bool isFilteredBySubs = false;

  Future<List<LastInfo>> _fetchLastInfos() async {
    Dio dio = Dio();

    final response = await dio.get("$baseUrl/news");

    List<LastInfo> lastInfos = [];
    response.data.forEach((li) => lastInfos.add(LastInfo.fromJson(li)));
    return lastInfos;
  }

  @override
  void initState() {
    _lastInfos = _fetchLastInfos();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(appBar: AppBar()),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: double.infinity,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dernières informations',
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text(
                      "Sur cette page, vous pourrez suivre l'actualité de différents pays en temps réel. Elle regroupe les dernières informations et permet de vous informer quant à la situation du pays, notamment concernant les déclarations de guerre, les maladies, les catastrophes naturelles, les événements politiques et économiques, etc. ",
                      style: Theme.of(context).textTheme.bodyLarge),
                  Text(
                      "Vous pouvez également choisir d’utiliser vos abonnements afin de ne voir que les pays qui répondent à vos attentes.",
                      style: Theme.of(context).textTheme.bodyLarge),
                  FutureBuilder(
                      future: _lastInfos,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const CustomErrorWidget(
                                text:
                                    "Une erreur est survenue lorsque nous avons essayé d'afficher ces informations. Veuillez réessayer plus tard.");
                          } else {
                            return LastInfoList(lastInfos: snapshot.data!);
                          }
                        } else {
                          return const Loader();
                        }
                      })
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
