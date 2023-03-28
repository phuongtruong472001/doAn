import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Person {
  int? id;
  String? name;
  Person({
    this.id,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Person.fromMap(Map<String, dynamic> json) {
    return Person(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source) as Map<String, dynamic>);
}
