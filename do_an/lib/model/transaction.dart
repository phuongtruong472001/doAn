import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Transaction {
  int? id;
  int? value;
  String? description;
  int? eventId;
  int? categoryId;
  DateTime? executionTime;
  int? fundID;
  String eventName;
  String fundName;
  String categoryName;
  Transaction({
    this.id = 0,
    this.value = 0,
    this.description = "",
    this.eventId = 0,
    this.categoryId = -1,
    this.executionTime,
    this.fundID = 0,
    this.categoryName = "",
    this.fundName = "",
    this.eventName = "",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'description': description,
      'eventId': eventId,
      'categoryId': categoryId,
      'executionTime': executionTime?.millisecondsSinceEpoch.toString(),
      'fundID': fundID,
      'eventName': eventName,
      'fundName': fundName,
      'categoryName': categoryName,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] != null ? map['id'] as int : null,
      value: map['value'] != null ? map['value'] as int : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      eventId: map['eventId'] != null ? map['eventId'] as int : null,
      categoryId: map['categoryId'] != null ? map['categoryId'] as int : null,
      executionTime: map['executionTime'] != null
          ? DateTime.parse(map['executionTime'])
          : null,
      fundID: map['fundID'] != null ? map['fundID'] as int : null,
      eventName: map['eventName'] as String,
      fundName: map['fundName'] as String,
      categoryName: map['categoryName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);
}
