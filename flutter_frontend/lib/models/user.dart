import 'package:flutter_frontend/models/criteria.dart';
import 'package:flutter_frontend/models/risk.dart';

class User {
  int id;
  String email;
  String firstName;
  String lastName;

  Criteria? riskWomenChildren;
  Criteria? riskLgbt;
  Criteria? riskCustoms;
  Criteria? riskClimate;
  Criteria? riskSociopolitical;
  Criteria? riskSanitary;
  Criteria? riskSecurity;
  Criteria? riskFood;

  User(
      this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.riskWomenChildren,
      this.riskLgbt,
      this.riskCustoms,
      this.riskClimate,
      this.riskSociopolitical,
      this.riskSanitary,
      this.riskSecurity,
      this.riskFood);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['email'],
      json['first_name'],
      json['last_name'],
      Criteria.fromJsonOrNull(json['criteria_women_children']),
      Criteria.fromJsonOrNull(json['criteria_lgbt']),
      Criteria.fromJsonOrNull(json['criteria_customs']),
      Criteria.fromJsonOrNull(json['criteria_climate']),
      Criteria.fromJsonOrNull(json['criteria_sociopolitical']),
      Criteria.fromJsonOrNull(json['criteria_sanitary']),
      Criteria.fromJsonOrNull(json['criteria_security']),
      Criteria.fromJsonOrNull(json['criteria_allergy']),
    );
  }

  @override
  String toString() {
    return "$firstName $lastName";
  }
}
