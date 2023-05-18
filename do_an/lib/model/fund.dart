import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Fund {
  int? id;
  String? name;
  String? icon;
  int start;
  int value;
  int? allowNegative;
  Fund({
    this.id,
    this.name,
    this.icon,
    this.value = 0,
    this.allowNegative = 1,
    this.start = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'icon': icon,
      'value': value,
      'allowNegative': allowNegative,
    };
  }

  factory Fund.fromMap(Map<String, dynamic> json) {
    return Fund(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      icon: json['icon'] != null ? json['icon'] as String : null,
      value: json['value'] != null ? json['value'] as int : 0,
      allowNegative: json['allowNegative'],
      start: json["start"] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Fund.fromJson(String source) =>
      Fund.fromMap(json.decode(source) as Map<String, dynamic>);
}
