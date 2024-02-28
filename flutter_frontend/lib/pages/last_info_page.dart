import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/last_info.dart';
import 'package:flutter_frontend/widgets/base/nav_bar.dart';
import 'package:flutter_frontend/widgets/criteria_switch.dart';
import 'package:flutter_frontend/widgets/last_info_list.dart';

class LastInfoPage extends StatefulWidget {
  const LastInfoPage({super.key});

  @override
  State<LastInfoPage> createState() => _LastInfoPageState();
}

class _LastInfoPageState extends State<LastInfoPage> {
  late Future<List<LastInfo>> _lastInfos;

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

  void _onChanged(bool b){
    // TODO:
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(appBar: AppBar()),
      body: Center(
        widthFactor: MediaQuery.of(context).size.width * 0.6,
        
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Last information'),
              const Text("Sur cette page, vous pourrez suivre l'actualité de différents pays en temps réel. Elle regroupe les dernières informations et permet de vous informer quant à la situation du pays, notamment concernant les déclarations de guerre, les maladies, les catastrophes naturelles, les événements politiques et économiques, etc. "),
              const Text("Vous pouvez également choisir d’utiliser vos abonnements afin de ne voir que les pays qui répondent à vos attentes."),
              Row(
                children: [
                  const Text('Utiliser mes abonnements'),
                  CriteriaSwitch(onChanged: _onChanged),
                ],
              ),
              FutureBuilder(
                future: _lastInfos, 
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      // TODO: re-design the error widget
                      return ErrorWidget("Could not fetch last information");
                    } else {
                      return LastInfoList(lastInfos: snapshot.data!);
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
                }
              )
              // ListView.builder(
              //   scrollDirection: Axis.vertical,
              //   padding: const EdgeInsets.all(8.0),
          
              // )
              
          
              
            ],
          ),
        ),
      ),
    );
  }
}
