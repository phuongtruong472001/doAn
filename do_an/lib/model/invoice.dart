import 'dart:convert';

import 'package:flutter/material.dart';

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
  int typeRepeat;
  String nameRepeat;
  TimeOfDay? timeOfDay;
  int quantityTime;
  int typeTime;
  Invoice({
    this.id = 0,
    this.value = 0,
    this.description = "",
    this.eventID = -1,
    this.categoryID = -1,
    this.categoryName = "",
    this.fundName = "",
    this.executionTime,
    this.fundId = -1,
    this.notificationTime,
    this.typeOfNotification,
    this.allowNegative = 1,
    this.nameRepeat = "",
    this.quantityTime = 0,
    this.timeOfDay = const TimeOfDay(hour: 7, minute: 15),
    this.typeRepeat = 0,
    this.typeTime = 0,
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
      categoryID: json['categoryID'] != null ? json['categoryID'] as int : null,
      executionTime: json['executionTime'] != null
          ? DateTime.tryParse(json['executionTime'])
          : null,
      fundId: json['fundId'] != null ? json['fundId'] as int : null,
      notificationTime: json['notificationTime'] != null
          ? DateTime.tryParse(json['notificationTime'])
          : null,
      typeOfNotification: json['typeOfNotification'] != null
          ? json['typeOfNotification'] as int
          : null,
      fundName: json['fundName'] ?? "",
      categoryName: json['categoryName'] ?? "",
      allowNegative: json['allowNegative'] ?? 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory Invoice.fromJson(String source) =>
      Invoice.fromMap(json.decode(source) as Map<String, dynamic>);
}
