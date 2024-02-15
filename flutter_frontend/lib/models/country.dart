import 'package:flutter_frontend/models/risk.dart';

class Country {
  int id;
  String name;
  DateTime lastEdition;

  // TODO: add the risks (ignoring them for the moment)
  Risk? riskWomenChildren;
  Risk? riskLgbt;
  Risk? riskCustoms;
  Risk? riskClimate;
  Risk? riskSociopolitical;
  Risk? riskSanitary;
  Risk? riskSecurity;
  Risk? riskFood;

  Country(
      this.id,
      this.name,
      this.lastEdition,
      this.riskWomenChildren,
      this.riskLgbt,
      this.riskCustoms,
      this.riskClimate,
      this.riskSociopolitical,
      this.riskSanitary,
      this.riskSecurity,
      this.riskFood);

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      json['id'],
      json['name'],
      DateTime.parse(json['last_edition']),
      Risk.fromJsonOrNull(json['risk_women_children']),
      Risk.fromJsonOrNull(json['risk_lgbt']),
      Risk.fromJsonOrNull(json['risk_customs']),
      Risk.fromJsonOrNull(json['risk_climate']),
      Risk.fromJsonOrNull(json['risk_sociopolitical']),
      Risk.fromJsonOrNull(json['risk_sanitary']),
      Risk.fromJsonOrNull(json['risk_security']),
      Risk.fromJsonOrNull(json['risk_food']),
    );
  }

  get level {
    List<Risk?> risks = [
      riskWomenChildren,
      riskLgbt,
      riskCustoms,
      riskClimate,
      riskSociopolitical,
      riskSanitary,
      riskSecurity,
      riskFood
    ];

    // int sum = risks.fold(
    //     0, (previousValue, element) => previousValue + element!.level);

    int sum = 0;
    int notNullNb = 0;
    for (var element in risks) {
      if (element != null) {
        sum += element.level;
        notNullNb++;
      }
    }

    if (notNullNb == 0) notNullNb++;

    return (sum / notNullNb).round();
  }

  @override
  String toString() {
    return name;
  }
}
