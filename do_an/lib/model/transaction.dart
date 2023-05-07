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
  int? allowNegative;
  int isIncrease;
  bool isRepeat;
  int? typeTime;
  int? typeRepeat;
  DateTime? endTime;
  String imageLink;
  int amount;
  String iconFund;
  Transaction({
    this.id = 0,
    this.value = 0,
    this.description = "",
    this.eventId = -1,
    this.categoryId = -1,
    this.executionTime,
    this.fundID = -1,
    this.categoryName = "",
    this.fundName = "",
    this.eventName = "",
    this.allowNegative = 1,
    this.isIncrease = 0,
    this.isRepeat = false,
    this.endTime,
    this.typeRepeat = 0,
    this.typeTime = 0,
    this.imageLink = "",
    this.amount = 1,
    this.iconFund = "",
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
        allowNegative: map['allowNegative'],
        isIncrease: map["isIncrease"],
        isRepeat: map["isRepeat"] == 1,
        endTime: map['endTime'] != null ? DateTime.parse(map['endTime']) : null,
        typeRepeat: map["typeRepeat"],
        typeTime: map["typeTime"],
        imageLink: map["imageLink"] ?? "",
        amount: map["amount"] ?? 1,
        iconFund: map["iconFund"] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);
}
