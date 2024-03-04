import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RiskLevelLegend extends StatelessWidget{
  const RiskLevelLegend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset("assets/images/RiskLevel1.svg",
                  width: 30, 
                  height: 30),
              ),
              const Text("Prudence normale"),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset("assets/images/RiskLevel2.svg",
                  width: 30, 
                  height: 30),
              ),
              const Text("Grande prudence"),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset("assets/images/RiskLevel3.svg",
                  width: 30, 
                  height: 30),
              ),
              const Text("Eviter si possible"),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset("assets/images/RiskLevel4.svg",
                  width: 30, 
                  height: 30),
              ),
              const Text("Eviter tout voyages"),
            ],
          ),
        ],
      ),
      ),
    );
  }
}