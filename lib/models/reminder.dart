import 'package:flutter/material.dart' show required;
import 'package:remindmeof/models/category.dart';

class Reminder {
  int id;
  String title;
  String description;
  DateTime dateTime;
  DateTime timeToBeNotified;
  Category category;
  Duration repeatAfter;

  Reminder({
    @required this.id,
    this.title,
    this.description,
    this.dateTime,
    this.timeToBeNotified,
    this.category,
    this.repeatAfter,
  });
}
