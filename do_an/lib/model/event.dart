// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Event {
  int? id;
  String? name;
  String? icon;
  DateTime? date;
  int? allowNegative;
  int? estimateValue;
  Event({
    this.id,
    this.name,
    this.icon,
    this.date,
    this.allowNegative=1,
    this.estimateValue,
  });

  Map<String, dynamic> tojson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'icon': icon,
      'date': date?.millisecondsSinceEpoch,
      'estimateValue': estimateValue,
    };
  }

  factory Event.fromjson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      icon: json['icon'] != null ? json['icon'] as String : null,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      allowNegative: json["allowNegative"],
      estimateValue: json['estimateValue'],
    );
  }

  String toJson() => json.encode(tojson());

  factory Event.fromJson(String source) =>
      Event.fromjson(json.decode(source) as Map<String, dynamic>);
}
