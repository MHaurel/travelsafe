import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/models/user.dart';

class Subscription {
  int id;
  DateTime dateCreated;
  User user;
  Country country;

  Subscription(this.id, this.dateCreated, this.user, this.country);

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(json['id'], DateTime.parse(json['date_created']),
        User.fromJson(json['user']), Country.fromJson(json['country']));
  }

  @override
  String toString() {
    return "${user.fullName} -> ${country.name}";
  }
}
