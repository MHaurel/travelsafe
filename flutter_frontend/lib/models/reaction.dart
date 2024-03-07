import 'package:flutter_frontend/models/emoji.dart';
import 'package:flutter_frontend/models/message.dart';
import 'package:flutter_frontend/models/user.dart';

class Reaction {
  int id;
  User user;
  Message? message;
  Emoji emoji;

  Reaction(this.id, this.user, this.message, this.emoji);

  factory Reaction.fromJson(Map<String, dynamic> json) {
    return Reaction(json['id'], User.fromJson(json['user']), null,
        Emoji.fromJson(json['emoji']));
  }
}
