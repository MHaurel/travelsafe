class CriteriaType {
  int id;
  String name;

  CriteriaType(this.id, this.name);

  factory CriteriaType.fromJson(Map<String, dynamic> json) {
    return CriteriaType(json['id'], json['name']);
  }
}
