import 'package:flutter_frontend/models/criteria_type.dart';

class Criteria {
  int id;
  String name;
  int grade;
  List<CriteriaType> types;

  Criteria(this.id, this.name, this.grade, this.types);

  factory Criteria.fromJson(Map<String, dynamic> json) {
    List<CriteriaType> _types = [];
    json['types'].forEach((t) => _types.add(CriteriaType.fromJson(t)));

    return Criteria(json['id'], json['name'], json['grade'], json['types']);
  }

  static Criteria? fromJsonOrNull(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Criteria(json['id'], json['name'], json['grade'], []);
  }
}
