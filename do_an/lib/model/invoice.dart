import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Invoice {
  int? id;
  int? value;
  String? description;
  int? eventID;
  int? categoryID;
  DateTime? executionTime;
  int? fundId;
  String? categoryName;
  String? fundName;
  DateTime? notificationTime;
  int? typeOfNotification;
  int? allowNegative;
  Invoice({
    this.id,
    this.value,
    this.description,
    this.eventID,
    this.categoryID,
    this.categoryName,
    this.fundName,
    this.executionTime,
    this.fundId,
    this.notificationTime,
    this.typeOfNotification,
    this.allowNegative = 1,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'description': description,
      'eventID': eventID,
      'category': categoryID,
      'executionTime': executionTime?.millisecondsSinceEpoch,
      'fundId': fundId,
      'notificationTime': notificationTime?.millisecondsSinceEpoch,
      'typeOfNotification': typeOfNotification,
    };
  }

  factory Invoice.fromMap(Map<String, dynamic> json) {
    return Invoice(
        id: json['id'] != null ? json['id'] as int : null,
        value: json['value'] != null ? json['value'] as int : null,
        description:
            json['description'] != null ? json['description'] as String : null,
        eventID: json['eventID'] != null ? json['eventID'] as int : null,
        categoryID: json['categoryID'] != null ? json['category'] as int : null,
        executionTime: json['executionTime'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['executionTime'] as int)
            : null,
        fundId: json['fundId'] != null ? json['fundId'] as int : null,
        notificationTime: json['notificationTime'] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                json['notificationTime'] as int)
            : null,
        typeOfNotification: json['typeOfNotification'] != null
            ? json['typeOfNotification'] as int
            : null,
        fundName: json['fundName'] ?? "",
        categoryName: json['categoryName'] ?? "",
        allowNegative: json['allowNegative']);
  }

  String toJson() => json.encode(toMap());

  factory Invoice.fromJson(String source) =>
      Invoice.fromMap(json.decode(source) as Map<String, dynamic>);
}
