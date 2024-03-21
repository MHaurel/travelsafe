import 'dart:math';
import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/handlers.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/custom_error_widget.dart';
import 'package:flutter_frontend/widgets/base/loader.dart';
import 'package:flutter_frontend/widgets/base/pub.dart';
import 'package:flutter_frontend/widgets/collaborative_space.dart';
import 'package:flutter_frontend/widgets/country_sections_navigation.dart';
import 'package:flutter_frontend/widgets/dialogs/connexion_dialog.dart';
import 'package:flutter_frontend/widgets/dialogs/unsubscribe_dialog.dart';
import 'package:flutter_frontend/widgets/last_two_news_preview_for_country.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_frontend/widgets/base/custom_icon_button.dart';
import 'package:flutter_frontend/widgets/base/nav_bar.dart';
import 'package:flutter_frontend/widgets/country_sections_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key, required this.countryIndex});

  final int countryIndex;

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  late Future<Country> _country;

  @override
  void initState() {
    _country = _fetchCountry();
    super.initState();
  }

  void _download(Country country) async {
    // bool isMobile = Platform.isAndroid || Platform.isIOS;
    bool isMobile = false;
    await downloadCountrySheet(country, isMobile);
  }

  Future<Country> _fetchCountry() async {
    Dio dio = Dio();
    final response = await dio.get("$baseUrl/country/${widget.countryIndex}/");

    Country country = Country.fromJson(response.data);
    return country;
  }

  Widget _buildTitle(Country country, BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: SvgPicture.asset(
                    "assets/images/RiskLevel${country.level}.svg",
                    width: 100,
                    height: 100),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(country.name,
                  style: Theme.of(context).textTheme.headlineLarge),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                CustomIconButton(
                    onPressed: () => _download(country),
                    text: "Télécharger",
                    icon: Icons.download),
                const SizedBox(
                    width: 8), //to add the white space between the buttons
                Provider.of<UserProvider>(context, listen: true)
                        .isSubbed(country)
                    ? CustomIconButton(
                        onPressed: () => showDialog(
                            context: context,
                            builder: (context) => UnsubscribeDialog(
                                  countryIndex: country.id,
                                )),
                        text: "Se désabonner",
                        icon: Icons.notifications_off)
                    : CustomIconButton(
                        onPressed: () {
                          // If the user is not connected : show login dialog
                          if (Provider.of<UserProvider>(context, listen: false)
                              .isSignedIn()) {
                            Provider.of<UserProvider>(context, listen: false)
                                .subscribe(country.id);
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => const ConnexionDialog());
                          }
                        },
                        text: "S'abonner",
                        icon: Icons.notification_add),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBar(
          appBar: AppBar(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: FutureBuilder(
              future: _country,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const CustomErrorWidget(
                        text:
                            "Impossible de récupérer les informations concernant le pays.");
                  } else {
                    List<Map<String, dynamic>> countrySections = [
                      {
                        "title": "Sécurité du pays",
                        "value": snapshot.data!.securityDescription
                      },
                      {
                        "title": "Zones à risques",
                        "value": snapshot.data!.socipoliticalDescription
                      },
                      {
                        "title": "Droits des femmes et des enfants",
                        "value": snapshot.data!.womenChildrenDescription
                      },
                      {
                        "title": "Droits LGBTQ+",
                        "value": snapshot.data!.lgbtDescription
                      },
                      {
                        "title": "Allergènes",
                        "value": snapshot.data!.foodDescription
                      },
                      {
                        "title": "Météorologie",
                        "value": snapshot.data!.climateDescription
                      },
                      {
                        "title": "Us et coutumes",
                        "value": snapshot.data!.customsDescription
                      },
                      {
                        "title": "Conditions sanitaires",
                        "value": snapshot.data!.sanitaryDescription
                      },
                    ];

                    return Row(children: [
                      Drawer(
                          shape: Border(
                              right: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 4)),
                          backgroundColor: Colors.transparent,
                          surfaceTintColor: Colors.transparent,
                          child: ListView.builder(
                            itemCount: countrySections.length,
                            itemBuilder: (context, index) => ListTile(
                              title: Text(countrySections[index]['title']),
                              enabled: false,
                            ),
                          )),
                      Expanded(
                          flex: 6,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: ListView(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: StickyHeader(
                                  header: _buildTitle(snapshot.data!, context),
                                  content: Column(
                                    children: [
                                      LastTwoNewsPreviewForCountry(
                                          country: snapshot.data!),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: countrySections.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  countrySections[index]
                                                      ['title'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .titleMedium!
                                                              .fontWeight,
                                                      fontSize:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .titleMedium!
                                                              .fontSize,
                                                      fontFamily:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .titleMedium!
                                                              .fontFamily,
                                                      color: const Color(
                                                          0xff478B85))),
                                              Text(countrySections[index]
                                                  ['value']),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CollaborativeSpace(
                                countryIndex: snapshot.data!.id,
                              ),
                            ]),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 62.5, right: 42),
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: const Column(
                            children: [
                              Pub(),
                              Pub(),
                              Pub(),
                            ],
                          ),
                        ),
                      ),
                    ]);
                  }
                } else {
                  return const Loader();
                }
              })),
        ));
  }
}
