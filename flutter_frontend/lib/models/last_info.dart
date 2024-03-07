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
        DateTime.parse(json['date']), Country.fromJson(json['country']));
  }

  int get timeElapsed {
    DateTime now = DateTime.now().toUtc();
    return now.difference(createdAt).inHours;
  }
}
