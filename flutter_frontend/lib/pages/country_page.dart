import 'dart:html';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/widgets/collaborative_space.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_frontend/widgets/base/custom_icon_button.dart';



class CountryPage extends StatefulWidget {
  const CountryPage({super.key, required this.countryIndex});

  final int countryIndex;

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  late int _countryIndex;
  late Future<Country> _country;
  

  @override
  void initState() {
    _country = _fetchCountry();
    super.initState();
  }

  void _download() {
    // TODO: code function
  }

  void _subscribe() {
    //TODO: code function + icon change
  }
  
  Future<Country> _fetchCountry() async {
    Dio dio = Dio();
    // TODO: switch to named route
    final response = await dio.get("$baseUrl/country/${widget.countryIndex}/");

    Country country = Country.fromJson(response.data);
    return country;
  }

  
  Hero _buildTitle(AsyncSnapshot snapshot, BuildContext context) {
    if (snapshot.data!.level ==1){
     return  Hero(tag: "countryName", child: 
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SvgPicture.asset("assets/images/RiskLevel1.svg",
                      width: 100, 
                      height: 100),
                  ),
                  Text("${snapshot.data!.name}", style: Theme.of(context).textTheme.headlineLarge),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  CustomIconButton(
                    onPressed: () => _download(),
                    text: "Télécharger",
                    icon: Icons.download),
                  CustomIconButton(
                    onPressed: () => _subscribe(),
                    text: "S'abonner",
                    icon: Icons.notifications),
                ],
              ),
          ],
        ),
      );
    }else if (snapshot.data!.level ==2){
      return  Hero(tag: "countryName", child: 
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SvgPicture.asset("assets/images/RiskLevel2.svg",
                      width: 100, 
                      height: 100),
                  ),
                  Text("${snapshot.data!.name}", style: Theme.of(context).textTheme.headlineLarge),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  CustomIconButton(
                    onPressed: () => _download(),
                    text: "Télécharger",
                    icon: Icons.download),
                  CustomIconButton(
                    onPressed: () => _subscribe(),
                    text: "S'abonner",
                    icon: Icons.notifications),
                ],
              ),
          ],
        ),
      );
    }else if (snapshot.data!.level ==3){
      return  Hero(tag: "countryName", child: 
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SvgPicture.asset("assets/images/RiskLevel3.svg",
                      width: 100, 
                      height: 100),
                  ),
                  Text("${snapshot.data!.name}", style: Theme.of(context).textTheme.headlineLarge),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  CustomIconButton(
                    onPressed: () => _download(),
                    text: "Télécharger",
                    icon: Icons.download),
                  CustomIconButton(
                    onPressed: () => _subscribe(),
                    text: "S'abonner",
                    icon: Icons.notifications),
                ],
              ),
          ],
        ),
      );
    }else if (snapshot.data!.level ==4){
      return  Hero(tag: "countryName", child: 
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SvgPicture.asset("assets/images/RiskLevel4.svg",
                      width: 100, 
                      height: 100),
                  ),
                  Text("${snapshot.data!.name}", style: Theme.of(context).textTheme.headlineLarge),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  CustomIconButton(
                    onPressed: () => _download(),
                    text: "Télécharger",
                    icon: Icons.download),
                  CustomIconButton(
                    onPressed: () => _subscribe(),
                    text: "S'abonner",
                    icon: Icons.notifications),
                ],
              ),
          ],
        ),
      );
    }else{
      return const Hero(
          tag: "countryName", child: Text("An error has occyured"));
    }
  }

  
  @override
  Widget build(BuildContext context) {
    // _countryIndex = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8),
      child: FutureBuilder(
          future: _country,
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // TODO: re-design the error widget
                return ErrorWidget(
                    "Could not fetch country with index: ${widget.countryIndex}");
              } else {
                return Column(
                  children: [
                    _buildTitle(snapshot, context),
                    // Hero(tag: "countryName", child: Text("${snapshot.data!.level}")),
                    CollaborativeSpace(
                      countryIndex: snapshot.data!.id,
                    )
                  ],
                );
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
                    child: Text('Awaiting result...', style: Theme.of(context).textTheme.bodyLarge,),
                  ),
                ]),
              );
            }
          })),
    ));
  }
}
