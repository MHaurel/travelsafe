class RiskLevel {
  int id;
  int level;
  String label;

  RiskLevel(this.id, this.level, this.label);

  factory RiskLevel.fromJson(Map<String, dynamic> json) {
    return RiskLevel(json['id'], json['level'], json['label']);
  }
}
