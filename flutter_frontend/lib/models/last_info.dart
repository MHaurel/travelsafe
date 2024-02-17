import 'package:flutter_frontend/models/country.dart';

class LastInfo {
  int id;
  String title;
  String content;
  DateTime createdAt;
  Country country;

  LastInfo(this.id, this.title, this.content, this.createdAt, this.country);

  factory LastInfo.fromJson(Map<String, dynamic> json) {
    return LastInfo(json['id'], json['title'], json['content'],
        json['createdAt'], Country.fromJson(json['country']));
  }
}
