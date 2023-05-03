// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

enum TypeRepeat {
  everyDay,
  everyWeek,
  everyMonth,
}

class RepeatTime {
  int typeRepeat;
  String nameRepeat;
  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  int quantityTime;
  int typeTime;
  bool isRepeat;
  int amount;
  RepeatTime({
    this.typeRepeat = 0,
    this.nameRepeat = "",
    this.dateTime,
    this.timeOfDay,
    this.quantityTime = 1,
    this.typeTime = 0,
    this.isRepeat = false,
    this.amount = 1,
  });

  factory RepeatTime.fromJson(Map<String, dynamic> map) {
    return RepeatTime(
      typeRepeat: map['typeRepeat'] as int,
      nameRepeat: map['nameRepeat'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      timeOfDay: TimeOfDay.fromDateTime(
        DateTime.tryParse(map['timeOfDay']) ?? DateTime.now(),
      ),
      quantityTime: map['quantityTime'] as int,
      typeTime: map['typeTime'] as int,
    );
  }
}
