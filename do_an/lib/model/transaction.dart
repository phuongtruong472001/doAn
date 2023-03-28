import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Transaction {
  int? id;
  int? value;
  String? desciption;
  int? eventId;
  int? categoryId;
  DateTime? executionTime;
  int? fundID;
  Transaction({
    this.id,
    this.value,
    this.desciption,
    this.eventId,
    this.categoryId,
    this.executionTime,
    this.fundID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'desciption': desciption,
      'eventId': eventId,
      'categoryId': categoryId,
      'executionTime': executionTime?.millisecondsSinceEpoch,
      'fundID': fundID,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] != null ? map['id'] as int : null,
      value: map['value'] != null ? map['value'] as int : null,
      desciption: map['desciption'] != null ? map['desciption'] as String : null,
      eventId: map['eventId'] != null ? map['eventId'] as int : null,
      categoryId: map['categoryId'] != null ? map['categoryId'] as int : null,
      executionTime: map['executionTime'] != null ? DateTime.fromMillisecondsSinceEpoch(map['executionTime'] as int) : null,
      fundID: map['fundID'] != null ? map['fundID'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source) as Map<String, dynamic>);
}
