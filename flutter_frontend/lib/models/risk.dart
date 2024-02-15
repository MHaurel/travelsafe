import 'package:flutter_frontend/models/risk_level.dart';

class Risk {
  int id;
  String name;
  String description;
  // RiskLevel riskLevel; // FIXME:
  int riskLevel;

  Risk(this.id, this.name, this.description, this.riskLevel);

  factory Risk.fromJson(Map<String, dynamic> json) {
    return Risk(
        json['id'], json['name'], json['description'], json['risk_level']);
  }

  static Risk? fromJsonOrNull(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Risk(
      json['id'],
      json['name'],
      json['description'],
      json['risk_level'],
    );
  }

  int get level {
    // return riskLevel.level; // FIXME:
    return riskLevel;
  }
}
