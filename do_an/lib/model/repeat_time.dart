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
  DateTime dateTime;
  TimeOfDay timeOfDay;
  int quantityTime;
  int typeTime;
  RepeatTime({
    required this.typeRepeat,
    required this.nameRepeat,
    required this.dateTime,
    required this.timeOfDay,
    required this.quantityTime,
    required this.typeTime,
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
