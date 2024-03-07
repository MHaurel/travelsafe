import 'package:flutter_frontend/models/criteria.dart';

class User {
  int? id;
  String? email;
  String? firstName;
  String? lastName;

  Criteria? criteriaWomenChildren;
  Criteria? criteriaLgbt;
  Criteria? criteriaCustoms;
  Criteria? criteriaClimate;
  Criteria? criteriaSociopolitical;
  Criteria? criteriaSanitary;
  Criteria? criteriaSecurity;
  Criteria? criteriaFood;

  String? accessToken;
  String? refreshToken;

  User(
      this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.criteriaWomenChildren,
      this.criteriaLgbt,
      this.criteriaCustoms,
      this.criteriaClimate,
      this.criteriaSociopolitical,
      this.criteriaSanitary,
      this.criteriaSecurity,
      this.criteriaFood,
      this.accessToken,
      this.refreshToken);

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
        json['access'],
        json['refresh']);
  }

  @override
  String toString() {
    return "$firstName $lastName";
  }

  set user(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    criteriaWomenChildren =
        Criteria.fromJsonOrNull(json['criteria_women_children']);
    criteriaLgbt = Criteria.fromJsonOrNull(json['criteria_lgbt']);
    criteriaCustoms = Criteria.fromJsonOrNull(json['criteria_customs']);
    criteriaClimate = Criteria.fromJsonOrNull(json['criteria_climate']);
    criteriaSociopolitical =
        Criteria.fromJsonOrNull(json['criteria_sociopolitical']);
    criteriaSanitary = Criteria.fromJsonOrNull(json['criteria_sanitary']);
    criteriaSecurity = Criteria.fromJsonOrNull(json['criteria_security']);
    criteriaFood = Criteria.fromJsonOrNull(json['criteria_allergy']);
    accessToken = json['access'];
    refreshToken = json['refresh'];
  }

  String get fullName => "$firstName $lastName";
}
