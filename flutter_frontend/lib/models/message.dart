class Message {
  int id;
  String content;
  DateTime dateCreated;

  // FIXME: replace by the actual User and Country classes (or do multiple requests...)
  int country;
  int user;

  Message(this.id, this.content, this.dateCreated, this.country, this.user);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(json['id'], json['content'], DateTime.parse(json['date']),
        json['country'], json['user']);
  }
}
