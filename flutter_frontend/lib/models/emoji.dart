class Emoji {
  int id;
  String name;
  String icon;

  Emoji(this.id, this.name, this.icon);

  factory Emoji.fromJson(Map<String, dynamic> json) {
    return Emoji(json['id'], json['name'], json['icon']);
  }
}
