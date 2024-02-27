class Emoji {
  int id;
  String name;
  int icon;

  Emoji(this.id, this.name, this.icon);

  factory Emoji.fromJson(Map<String, dynamic> json) {
    return Emoji(json['id'], json['name'], json['icon']);
  }
}
