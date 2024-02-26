import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/models/user.dart';

class Message {
  int id;
  String content;
  DateTime dateCreated;

  Country country;
  User user;

  Message(this.id, this.content, this.dateCreated, this.country, this.user);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(json['id'], json['content'], DateTime.parse(json['date']),
        Country.fromJson(json['country']), User.fromJson(json['user']));
  }
}
