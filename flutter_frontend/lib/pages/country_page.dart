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

  void _subscribe() {
    //TODO: code function + icon change
  }

  void _unsubscribe() {
    // TODO: code function
  }

  Future<Country> _fetchCountry() async {
    Dio dio = Dio();
    // TODO: switch to named route
    final response = await dio.get("$baseUrl/country/${widget.countryIndex}/");

    Country country = Country.fromJson(response.data);
    return country;
  }

  Hero _buildTitle(Country country, BuildContext context) {
    return Hero(
      tag: "countryName",
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

    // TODO: in the case of an error
    // return const Hero(
    // //       tag: "countryName", child: Text("An error has occyured"));
  }

  @override
  Widget build(BuildContext context) {
    // _countryIndex = ModalRoute.of(context)!.settings.arguments as int;
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
                    // TODO: re-design the error widget
                    return ErrorWidget(
                        "Could not fetch country with index: ${widget.countryIndex}");
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
                                  content: ListView.builder(
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
                                          Text(countrySections[index]['title'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium),
                                          Text(countrySections[index]['value'])
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              CollaborativeSpace(
                                countryIndex: snapshot.data!.id,
                              ),
                            ]),
                          ))
                    ]);

                    // return Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     // Left col with legend
                    //     Expanded(
                    //       flex: 2,
                    //       child: const SizedBox(),
                    //       // child: CountrySectionsNavigation(),
                    //     ),

                    //     Expanded(
                    //       flex: 6,
                    //       child: ListView(
                    //         children: [
                    //           StickyHeader(
                    //             header: _buildTitle(snapshot.data!, context),
                    //             content: ListView.builder(
                    //               shrinkWrap: true,
                    //               physics: const NeverScrollableScrollPhysics(),
                    //               scrollDirection: Axis.vertical,
                    //               itemCount: countrySections.length,
                    //               itemBuilder: (context, index) {
                    //                 return Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(countrySections[index]['title'],
                    //                         style: Theme.of(context)
                    //                             .textTheme
                    //                             .titleMedium),
                    //                     Text(countrySections[index]['value'])
                    //                   ],
                    //                 );
                    //               },
                    //             ),
                    //           ),
                    //           // _buildTitle(snapshot.data!, context),
                    //           // ListView.builder(
                    //           //   shrinkWrap: true,
                    //           //   physics: const NeverScrollableScrollPhysics(),
                    //           //   scrollDirection: Axis.vertical,
                    //           //   itemCount: countrySections.length,
                    //           //   itemBuilder: (context, index) {
                    //           //     return Column(
                    //           //       crossAxisAlignment:
                    //           //           CrossAxisAlignment.start,
                    //           //       children: [
                    //           //         Text(countrySections[index]['title'],
                    //           //             style: Theme.of(context)
                    //           //                 .textTheme
                    //           //                 .titleMedium),
                    //           //         Text(countrySections[index]['value'])
                    //           //       ],
                    //           //     );
                    //           //   },
                    //           // ),
                    //           CollaborativeSpace(
                    //             countryIndex: snapshot.data!.id,
                    //           ),
                    //           // StickyHeader(
                    //           //     header: Container(
                    //           //       color: Theme.of(context)
                    //           //           .colorScheme
                    //           //           .background,
                    //           //       child: _buildTitle(snapshot.data!, context),
                    //           //     ),
                    //           //     content: Column(children: [
                    //           //       // TODO: (will work when branch will be merged)
                    //           //       // LastTwoNewsPreviewForCountry(
                    //           //       //     country: snapshot.data!),

                    //           //       // Text(
                    //           //       //     "this is som very long text Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum nec lacus id volutpat. Mauris et aliquet arcu. Quisque ut turpis vitae est sodales auctor ac eu elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aenean semper augue eu diam porttitor ullamcorper. Nam rhoncus nisl enim, sit amet bibendum urna placerat nec. Morbi volutpat at ipsum non pretium. Donec id enim condimentum, feugiat nulla nec, luctus massa. Donec mollis sollicitudin interdum. Donec in metus nec libero molestie sodales. Aliquam mattis urna auctor, finibus urna eget, fermentum orci. Sed placerat arcu dolor, in tempor lorem luctus vel. Praesent sollicitudin dignissim facilisis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed suscipit ante quis odio iaculis venenatis.Nam commodo tortor a lacus porta blandit. Nulla venenatis mi accumsan purus scelerisque ornare. Suspendisse sit amet vulputate nisl. Nulla gravida augue ornare, imperdiet lacus id, egestas sapien. Quisque porta tempus lacus quis viverra. Donec vitae aliquam leo, eget placerat risus. Sed tempus luctus orci in maximus. Fusce sagittis in nisl quis interdum. Nullam convallis, augue vitae varius placerat, ante ipsum fringilla nisi, ut euismod mauris lectus et dui. Donec elit est, aliquam a eros non, ultrices congue diam.Vestibulum eget tortor et nunc elementum vestibulum in vitae elit. Integer aliquet mattis risus a suscipit. Maecenas massa sapien, sodales id placerat vitae, condimentum eget lacus. In ipsum purus, tempus eu pretium sit amet, pretium et lacus. Maecenas commodo, quam vel bibendum porta, ligula purus tincidunt ipsum, sit amet rhoncus odio enim maximus est. Etiam pulvinar ipsum non ipsum dictum volutpat. Mauris et ligula lobortis, placerat eros non, dignissim dui. Fusce nunc dolor, mollis eu eros eu, placerat lacinia mi. Duis sit amet justo commodo, euismod dolor vel, tincidunt lorem. Curabitur lacinia erat sed est rhoncus, non lobortis orci tristique. Ut ac ex id libero vestibulum mattis. Donec a ornare augue. Praesent vestibulum vulputate libero, eu hendrerit ante accumsan eget. Maecenas porttitor lorem massa, in pretium ipsum tempus ut.Ut iaculis diam a est aliquam consequat. Curabitur consequat enim odio, vel blandit nibh euismod vitae. Sed laoreet convallis malesuada. Etiam eget risus nisl. Aliquam hendrerit dui justo, nec gravida erat volutpat in. Fusce vitae mauris non erat blandit porta. Donec ultricies purus id turpis convallis, id placerat ligula tincidunt. Sed condimentum scelerisque ullamcorper. Cras eget nibh ac erat blandit cursus. Aliquam molestie malesuada ligula, sit amet congue ex lobortis tempus. Vestibulum ut mollis odio, ut sodales nisl. Morbi sagittis, eros ut laoreet sagittis, massa ligula tempus leo, vitae sollicitudin leo mauris sed sem. Vivamus tortor leo, tempor nec porttitor sed, fringilla a felis. Phasellus et aliquet magna, nec consequat odio. In vulputate, nisi nec posuere pretium, ipsum dolor egestas ligula, eu commodo augue ipsum eu dolor.Sed feugiat ultricies sem, vitae iaculis quam viverra vel. Curabitur vitae felis et mi interdum fringilla et quis justo. Integer feugiat tristique tortor, eu ornare magna hendrerit nec. Morbi tempor lobortis felis sit amet lobortis. Etiam vitae libero vel sem malesuada efficitur ornare ac purus. Ut vel commodo turpis. Suspendisse vestibulum fermentum nisl, eget condimentum erat consequat nec. Praesent dapibus nisl finibus sodales vulputate. Curabitur nec sapien condimentum, finibus nisl sit amet, iaculis sapien. Maecenas arcu ipsum, vulputate at lorem sed, accumsan tristique mauris. Donec vitae egestas ante, nec vestibulum dolor. Sed quis rutrum felis. Pellentesque ut pulvinar massa, vitae tincidunt metus."),
                    //           //       // Text(
                    //           //       //     "this is som very long text Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum nec lacus id volutpat. Mauris et aliquet arcu. Quisque ut turpis vitae est sodales auctor ac eu elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aenean semper augue eu diam porttitor ullamcorper. Nam rhoncus nisl enim, sit amet bibendum urna placerat nec. Morbi volutpat at ipsum non pretium. Donec id enim condimentum, feugiat nulla nec, luctus massa. Donec mollis sollicitudin interdum. Donec in metus nec libero molestie sodales. Aliquam mattis urna auctor, finibus urna eget, fermentum orci. Sed placerat arcu dolor, in tempor lorem luctus vel. Praesent sollicitudin dignissim facilisis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed suscipit ante quis odio iaculis venenatis.Nam commodo tortor a lacus porta blandit. Nulla venenatis mi accumsan purus scelerisque ornare. Suspendisse sit amet vulputate nisl. Nulla gravida augue ornare, imperdiet lacus id, egestas sapien. Quisque porta tempus lacus quis viverra. Donec vitae aliquam leo, eget placerat risus. Sed tempus luctus orci in maximus. Fusce sagittis in nisl quis interdum. Nullam convallis, augue vitae varius placerat, ante ipsum fringilla nisi, ut euismod mauris lectus et dui. Donec elit est, aliquam a eros non, ultrices congue diam.Vestibulum eget tortor et nunc elementum vestibulum in vitae elit. Integer aliquet mattis risus a suscipit. Maecenas massa sapien, sodales id placerat vitae, condimentum eget lacus. In ipsum purus, tempus eu pretium sit amet, pretium et lacus. Maecenas commodo, quam vel bibendum porta, ligula purus tincidunt ipsum, sit amet rhoncus odio enim maximus est. Etiam pulvinar ipsum non ipsum dictum volutpat. Mauris et ligula lobortis, placerat eros non, dignissim dui. Fusce nunc dolor, mollis eu eros eu, placerat lacinia mi. Duis sit amet justo commodo, euismod dolor vel, tincidunt lorem. Curabitur lacinia erat sed est rhoncus, non lobortis orci tristique. Ut ac ex id libero vestibulum mattis. Donec a ornare augue. Praesent vestibulum vulputate libero, eu hendrerit ante accumsan eget. Maecenas porttitor lorem massa, in pretium ipsum tempus ut.Ut iaculis diam a est aliquam consequat. Curabitur consequat enim odio, vel blandit nibh euismod vitae. Sed laoreet convallis malesuada. Etiam eget risus nisl. Aliquam hendrerit dui justo, nec gravida erat volutpat in. Fusce vitae mauris non erat blandit porta. Donec ultricies purus id turpis convallis, id placerat ligula tincidunt. Sed condimentum scelerisque ullamcorper. Cras eget nibh ac erat blandit cursus. Aliquam molestie malesuada ligula, sit amet congue ex lobortis tempus. Vestibulum ut mollis odio, ut sodales nisl. Morbi sagittis, eros ut laoreet sagittis, massa ligula tempus leo, vitae sollicitudin leo mauris sed sem. Vivamus tortor leo, tempor nec porttitor sed, fringilla a felis. Phasellus et aliquet magna, nec consequat odio. In vulputate, nisi nec posuere pretium, ipsum dolor egestas ligula, eu commodo augue ipsum eu dolor.Sed feugiat ultricies sem, vitae iaculis quam viverra vel. Curabitur vitae felis et mi interdum fringilla et quis justo. Integer feugiat tristique tortor, eu ornare magna hendrerit nec. Morbi tempor lobortis felis sit amet lobortis. Etiam vitae libero vel sem malesuada efficitur ornare ac purus. Ut vel commodo turpis. Suspendisse vestibulum fermentum nisl, eget condimentum erat consequat nec. Praesent dapibus nisl finibus sodales vulputate. Curabitur nec sapien condimentum, finibus nisl sit amet, iaculis sapien. Maecenas arcu ipsum, vulputate at lorem sed, accumsan tristique mauris. Donec vitae egestas ante, nec vestibulum dolor. Sed quis rutrum felis. Pellentesque ut pulvinar massa, vitae tincidunt metus."),
                    //           //       // Text(
                    //           //       //     "this is som very long text Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum nec lacus id volutpat. Mauris et aliquet arcu. Quisque ut turpis vitae est sodales auctor ac eu elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aenean semper augue eu diam porttitor ullamcorper. Nam rhoncus nisl enim, sit amet bibendum urna placerat nec. Morbi volutpat at ipsum non pretium. Donec id enim condimentum, feugiat nulla nec, luctus massa. Donec mollis sollicitudin interdum. Donec in metus nec libero molestie sodales. Aliquam mattis urna auctor, finibus urna eget, fermentum orci. Sed placerat arcu dolor, in tempor lorem luctus vel. Praesent sollicitudin dignissim facilisis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed suscipit ante quis odio iaculis venenatis.Nam commodo tortor a lacus porta blandit. Nulla venenatis mi accumsan purus scelerisque ornare. Suspendisse sit amet vulputate nisl. Nulla gravida augue ornare, imperdiet lacus id, egestas sapien. Quisque porta tempus lacus quis viverra. Donec vitae aliquam leo, eget placerat risus. Sed tempus luctus orci in maximus. Fusce sagittis in nisl quis interdum. Nullam convallis, augue vitae varius placerat, ante ipsum fringilla nisi, ut euismod mauris lectus et dui. Donec elit est, aliquam a eros non, ultrices congue diam.Vestibulum eget tortor et nunc elementum vestibulum in vitae elit. Integer aliquet mattis risus a suscipit. Maecenas massa sapien, sodales id placerat vitae, condimentum eget lacus. In ipsum purus, tempus eu pretium sit amet, pretium et lacus. Maecenas commodo, quam vel bibendum porta, ligula purus tincidunt ipsum, sit amet rhoncus odio enim maximus est. Etiam pulvinar ipsum non ipsum dictum volutpat. Mauris et ligula lobortis, placerat eros non, dignissim dui. Fusce nunc dolor, mollis eu eros eu, placerat lacinia mi. Duis sit amet justo commodo, euismod dolor vel, tincidunt lorem. Curabitur lacinia erat sed est rhoncus, non lobortis orci tristique. Ut ac ex id libero vestibulum mattis. Donec a ornare augue. Praesent vestibulum vulputate libero, eu hendrerit ante accumsan eget. Maecenas porttitor lorem massa, in pretium ipsum tempus ut.Ut iaculis diam a est aliquam consequat. Curabitur consequat enim odio, vel blandit nibh euismod vitae. Sed laoreet convallis malesuada. Etiam eget risus nisl. Aliquam hendrerit dui justo, nec gravida erat volutpat in. Fusce vitae mauris non erat blandit porta. Donec ultricies purus id turpis convallis, id placerat ligula tincidunt. Sed condimentum scelerisque ullamcorper. Cras eget nibh ac erat blandit cursus. Aliquam molestie malesuada ligula, sit amet congue ex lobortis tempus. Vestibulum ut mollis odio, ut sodales nisl. Morbi sagittis, eros ut laoreet sagittis, massa ligula tempus leo, vitae sollicitudin leo mauris sed sem. Vivamus tortor leo, tempor nec porttitor sed, fringilla a felis. Phasellus et aliquet magna, nec consequat odio. In vulputate, nisi nec posuere pretium, ipsum dolor egestas ligula, eu commodo augue ipsum eu dolor.Sed feugiat ultricies sem, vitae iaculis quam viverra vel. Curabitur vitae felis et mi interdum fringilla et quis justo. Integer feugiat tristique tortor, eu ornare magna hendrerit nec. Morbi tempor lobortis felis sit amet lobortis. Etiam vitae libero vel sem malesuada efficitur ornare ac purus. Ut vel commodo turpis. Suspendisse vestibulum fermentum nisl, eget condimentum erat consequat nec. Praesent dapibus nisl finibus sodales vulputate. Curabitur nec sapien condimentum, finibus nisl sit amet, iaculis sapien. Maecenas arcu ipsum, vulputate at lorem sed, accumsan tristique mauris. Donec vitae egestas ante, nec vestibulum dolor. Sed quis rutrum felis. Pellentesque ut pulvinar massa, vitae tincidunt metus."),
                    //           //       // Text(
                    //           //       //     "this is som very long text Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum nec lacus id volutpat. Mauris et aliquet arcu. Quisque ut turpis vitae est sodales auctor ac eu elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aenean semper augue eu diam porttitor ullamcorper. Nam rhoncus nisl enim, sit amet bibendum urna placerat nec. Morbi volutpat at ipsum non pretium. Donec id enim condimentum, feugiat nulla nec, luctus massa. Donec mollis sollicitudin interdum. Donec in metus nec libero molestie sodales. Aliquam mattis urna auctor, finibus urna eget, fermentum orci. Sed placerat arcu dolor, in tempor lorem luctus vel. Praesent sollicitudin dignissim facilisis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed suscipit ante quis odio iaculis venenatis.Nam commodo tortor a lacus porta blandit. Nulla venenatis mi accumsan purus scelerisque ornare. Suspendisse sit amet vulputate nisl. Nulla gravida augue ornare, imperdiet lacus id, egestas sapien. Quisque porta tempus lacus quis viverra. Donec vitae aliquam leo, eget placerat risus. Sed tempus luctus orci in maximus. Fusce sagittis in nisl quis interdum. Nullam convallis, augue vitae varius placerat, ante ipsum fringilla nisi, ut euismod mauris lectus et dui. Donec elit est, aliquam a eros non, ultrices congue diam.Vestibulum eget tortor et nunc elementum vestibulum in vitae elit. Integer aliquet mattis risus a suscipit. Maecenas massa sapien, sodales id placerat vitae, condimentum eget lacus. In ipsum purus, tempus eu pretium sit amet, pretium et lacus. Maecenas commodo, quam vel bibendum porta, ligula purus tincidunt ipsum, sit amet rhoncus odio enim maximus est. Etiam pulvinar ipsum non ipsum dictum volutpat. Mauris et ligula lobortis, placerat eros non, dignissim dui. Fusce nunc dolor, mollis eu eros eu, placerat lacinia mi. Duis sit amet justo commodo, euismod dolor vel, tincidunt lorem. Curabitur lacinia erat sed est rhoncus, non lobortis orci tristique. Ut ac ex id libero vestibulum mattis. Donec a ornare augue. Praesent vestibulum vulputate libero, eu hendrerit ante accumsan eget. Maecenas porttitor lorem massa, in pretium ipsum tempus ut.Ut iaculis diam a est aliquam consequat. Curabitur consequat enim odio, vel blandit nibh euismod vitae. Sed laoreet convallis malesuada. Etiam eget risus nisl. Aliquam hendrerit dui justo, nec gravida erat volutpat in. Fusce vitae mauris non erat blandit porta. Donec ultricies purus id turpis convallis, id placerat ligula tincidunt. Sed condimentum scelerisque ullamcorper. Cras eget nibh ac erat blandit cursus. Aliquam molestie malesuada ligula, sit amet congue ex lobortis tempus. Vestibulum ut mollis odio, ut sodales nisl. Morbi sagittis, eros ut laoreet sagittis, massa ligula tempus leo, vitae sollicitudin leo mauris sed sem. Vivamus tortor leo, tempor nec porttitor sed, fringilla a felis. Phasellus et aliquet magna, nec consequat odio. In vulputate, nisi nec posuere pretium, ipsum dolor egestas ligula, eu commodo augue ipsum eu dolor.Sed feugiat ultricies sem, vitae iaculis quam viverra vel. Curabitur vitae felis et mi interdum fringilla et quis justo. Integer feugiat tristique tortor, eu ornare magna hendrerit nec. Morbi tempor lobortis felis sit amet lobortis. Etiam vitae libero vel sem malesuada efficitur ornare ac purus. Ut vel commodo turpis. Suspendisse vestibulum fermentum nisl, eget condimentum erat consequat nec. Praesent dapibus nisl finibus sodales vulputate. Curabitur nec sapien condimentum, finibus nisl sit amet, iaculis sapien. Maecenas arcu ipsum, vulputate at lorem sed, accumsan tristique mauris. Donec vitae egestas ante, nec vestibulum dolor. Sed quis rutrum felis. Pellentesque ut pulvinar massa, vitae tincidunt metus."),
                    //           //       // Text(
                    //           //       //     "this is som very long text Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum nec lacus id volutpat. Mauris et aliquet arcu. Quisque ut turpis vitae est sodales auctor ac eu elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aenean semper augue eu diam porttitor ullamcorper. Nam rhoncus nisl enim, sit amet bibendum urna placerat nec. Morbi volutpat at ipsum non pretium. Donec id enim condimentum, feugiat nulla nec, luctus massa. Donec mollis sollicitudin interdum. Donec in metus nec libero molestie sodales. Aliquam mattis urna auctor, finibus urna eget, fermentum orci. Sed placerat arcu dolor, in tempor lorem luctus vel. Praesent sollicitudin dignissim facilisis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed suscipit ante quis odio iaculis venenatis.Nam commodo tortor a lacus porta blandit. Nulla venenatis mi accumsan purus scelerisque ornare. Suspendisse sit amet vulputate nisl. Nulla gravida augue ornare, imperdiet lacus id, egestas sapien. Quisque porta tempus lacus quis viverra. Donec vitae aliquam leo, eget placerat risus. Sed tempus luctus orci in maximus. Fusce sagittis in nisl quis interdum. Nullam convallis, augue vitae varius placerat, ante ipsum fringilla nisi, ut euismod mauris lectus et dui. Donec elit est, aliquam a eros non, ultrices congue diam.Vestibulum eget tortor et nunc elementum vestibulum in vitae elit. Integer aliquet mattis risus a suscipit. Maecenas massa sapien, sodales id placerat vitae, condimentum eget lacus. In ipsum purus, tempus eu pretium sit amet, pretium et lacus. Maecenas commodo, quam vel bibendum porta, ligula purus tincidunt ipsum, sit amet rhoncus odio enim maximus est. Etiam pulvinar ipsum non ipsum dictum volutpat. Mauris et ligula lobortis, placerat eros non, dignissim dui. Fusce nunc dolor, mollis eu eros eu, placerat lacinia mi. Duis sit amet justo commodo, euismod dolor vel, tincidunt lorem. Curabitur lacinia erat sed est rhoncus, non lobortis orci tristique. Ut ac ex id libero vestibulum mattis. Donec a ornare augue. Praesent vestibulum vulputate libero, eu hendrerit ante accumsan eget. Maecenas porttitor lorem massa, in pretium ipsum tempus ut.Ut iaculis diam a est aliquam consequat. Curabitur consequat enim odio, vel blandit nibh euismod vitae. Sed laoreet convallis malesuada. Etiam eget risus nisl. Aliquam hendrerit dui justo, nec gravida erat volutpat in. Fusce vitae mauris non erat blandit porta. Donec ultricies purus id turpis convallis, id placerat ligula tincidunt. Sed condimentum scelerisque ullamcorper. Cras eget nibh ac erat blandit cursus. Aliquam molestie malesuada ligula, sit amet congue ex lobortis tempus. Vestibulum ut mollis odio, ut sodales nisl. Morbi sagittis, eros ut laoreet sagittis, massa ligula tempus leo, vitae sollicitudin leo mauris sed sem. Vivamus tortor leo, tempor nec porttitor sed, fringilla a felis. Phasellus et aliquet magna, nec consequat odio. In vulputate, nisi nec posuere pretium, ipsum dolor egestas ligula, eu commodo augue ipsum eu dolor.Sed feugiat ultricies sem, vitae iaculis quam viverra vel. Curabitur vitae felis et mi interdum fringilla et quis justo. Integer feugiat tristique tortor, eu ornare magna hendrerit nec. Morbi tempor lobortis felis sit amet lobortis. Etiam vitae libero vel sem malesuada efficitur ornare ac purus. Ut vel commodo turpis. Suspendisse vestibulum fermentum nisl, eget condimentum erat consequat nec. Praesent dapibus nisl finibus sodales vulputate. Curabitur nec sapien condimentum, finibus nisl sit amet, iaculis sapien. Maecenas arcu ipsum, vulputate at lorem sed, accumsan tristique mauris. Donec vitae egestas ante, nec vestibulum dolor. Sed quis rutrum felis. Pellentesque ut pulvinar massa, vitae tincidunt metus."),
                    //           //       // Expanded( // !
                    //           //       //   child: ListView.builder(
                    //           //       //     scrollDirection: Axis.vertical,
                    //           //       //     itemCount: countrySections.length,
                    //           //       //     itemBuilder: (context, index) {
                    //           //       //       return Column(
                    //           //       //         crossAxisAlignment:
                    //           //       //             CrossAxisAlignment.start,
                    //           //       //         children: [
                    //           //       //           Text(
                    //           //       //               countrySections[index]
                    //           //       //                   ['title'],
                    //           //       //               style: Theme.of(context)
                    //           //       //                   .textTheme
                    //           //       //                   .titleMedium),
                    //           //       //           Text(countrySections[index]
                    //           //       //               ['value'])
                    //           //       //         ],
                    //           //       //       );
                    //           //       //     },
                    //           //       //   ),
                    //           //       // ),
                    //           //       // CollaborativeSpace(
                    //           //       //   countryIndex: snapshot.data!.id,
                    //           //       // ),
                    //           //       // Text(
                    //           //       //     "this is som very long text Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum nec lacus id volutpat. Mauris et aliquet arcu. Quisque ut turpis vitae est sodales auctor ac eu elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aenean semper augue eu diam porttitor ullamcorper. Nam rhoncus nisl enim, sit amet bibendum urna placerat nec. Morbi volutpat at ipsum non pretium. Donec id enim condimentum, feugiat nulla nec, luctus massa. Donec mollis sollicitudin interdum. Donec in metus nec libero molestie sodales. Aliquam mattis urna auctor, finibus urna eget, fermentum orci. Sed placerat arcu dolor, in tempor lorem luctus vel. Praesent sollicitudin dignissim facilisis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed suscipit ante quis odio iaculis venenatis.Nam commodo tortor a lacus porta blandit. Nulla venenatis mi accumsan purus scelerisque ornare. Suspendisse sit amet vulputate nisl. Nulla gravida augue ornare, imperdiet lacus id, egestas sapien. Quisque porta tempus lacus quis viverra. Donec vitae aliquam leo, eget placerat risus. Sed tempus luctus orci in maximus. Fusce sagittis in nisl quis interdum. Nullam convallis, augue vitae varius placerat, ante ipsum fringilla nisi, ut euismod mauris lectus et dui. Donec elit est, aliquam a eros non, ultrices congue diam.Vestibulum eget tortor et nunc elementum vestibulum in vitae elit. Integer aliquet mattis risus a suscipit. Maecenas massa sapien, sodales id placerat vitae, condimentum eget lacus. In ipsum purus, tempus eu pretium sit amet, pretium et lacus. Maecenas commodo, quam vel bibendum porta, ligula purus tincidunt ipsum, sit amet rhoncus odio enim maximus est. Etiam pulvinar ipsum non ipsum dictum volutpat. Mauris et ligula lobortis, placerat eros non, dignissim dui. Fusce nunc dolor, mollis eu eros eu, placerat lacinia mi. Duis sit amet justo commodo, euismod dolor vel, tincidunt lorem. Curabitur lacinia erat sed est rhoncus, non lobortis orci tristique. Ut ac ex id libero vestibulum mattis. Donec a ornare augue. Praesent vestibulum vulputate libero, eu hendrerit ante accumsan eget. Maecenas porttitor lorem massa, in pretium ipsum tempus ut.Ut iaculis diam a est aliquam consequat. Curabitur consequat enim odio, vel blandit nibh euismod vitae. Sed laoreet convallis malesuada. Etiam eget risus nisl. Aliquam hendrerit dui justo, nec gravida erat volutpat in. Fusce vitae mauris non erat blandit porta. Donec ultricies purus id turpis convallis, id placerat ligula tincidunt. Sed condimentum scelerisque ullamcorper. Cras eget nibh ac erat blandit cursus. Aliquam molestie malesuada ligula, sit amet congue ex lobortis tempus. Vestibulum ut mollis odio, ut sodales nisl. Morbi sagittis, eros ut laoreet sagittis, massa ligula tempus leo, vitae sollicitudin leo mauris sed sem. Vivamus tortor leo, tempor nec porttitor sed, fringilla a felis. Phasellus et aliquet magna, nec consequat odio. In vulputate, nisi nec posuere pretium, ipsum dolor egestas ligula, eu commodo augue ipsum eu dolor.Sed feugiat ultricies sem, vitae iaculis quam viverra vel. Curabitur vitae felis et mi interdum fringilla et quis justo. Integer feugiat tristique tortor, eu ornare magna hendrerit nec. Morbi tempor lobortis felis sit amet lobortis. Etiam vitae libero vel sem malesuada efficitur ornare ac purus. Ut vel commodo turpis. Suspendisse vestibulum fermentum nisl, eget condimentum erat consequat nec. Praesent dapibus nisl finibus sodales vulputate. Curabitur nec sapien condimentum, finibus nisl sit amet, iaculis sapien. Maecenas arcu ipsum, vulputate at lorem sed, accumsan tristique mauris. Donec vitae egestas ante, nec vestibulum dolor. Sed quis rutrum felis. Pellentesque ut pulvinar massa, vitae tincidunt metus."),
                    //           //     ]))
                    //         ],
                    //       ),
                    //     ),

                    //     // Right col with ads
                    //     Expanded(
                    //       flex: 2,
                    //       child: Text("droite"),
                    //       // child: SizedBox(
                    //       //   // width: MediaQuery.of(context).size.width * 0.2,
                    //       //   height: double.infinity,
                    //       // ),
                    //     )
                    //   ],
                    // );
                  }
                } else {
                  return Center(
                    child: Column(children: [
                      const SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          'Awaiting result...',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ]),
                  );
                }
              })),
        ));
  }
}
