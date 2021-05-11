import 'package:flutter/material.dart' show Colors;
import 'package:remindmeof/models/category.dart';
import 'package:remindmeof/models/reminder.dart';

class AllReminders {
  List<Reminder> upcomingReminders = [
    Reminder(
      id: 0,
      title: "John's birthday",
      description: "Need to plan a suprise party",
      category: Category(title: "Birthday", color: Colors.red),
      dateTime: DateTime(2021, 5, 20, 20, 00),
      timeToBeNotified: DateTime(2021, 5, 17, 08, 00),
      repeatAfter: Duration(days: 1),
    ),
    Reminder(
      id: 1,
      title: "Credit Card Payment",
      description: "Pay due amount of credit card",
      category: Category(title: "Payment", color: Colors.blue),
      dateTime: DateTime(2021, 5, 25, 10, 00),
      timeToBeNotified: DateTime(2021, 5, 20, 08, 00),
      repeatAfter: Duration(days: 30),
    )
  ];
  List<Reminder> completedReminders = [
    Reminder(
      id: 2,
      title: "Ria's birthday",
      description: "Need to plan a suprise party",
      category: Category(title: "Birthday", color: Colors.red),
      dateTime: DateTime(2021, 5, 01, 20, 00),
      timeToBeNotified: DateTime(2021, 04, 28, 08, 00),
      repeatAfter: Duration(days: 7),
    ),
    Reminder(
      id: 3,
      title: "CSC 421 Mid-Term",
      description: "Start preparing for CSC 421 Mid-Term Exam",
      category: Category(title: "College", color: Colors.black),
      dateTime: DateTime(2021, 04, 05, 10, 00),
      timeToBeNotified: DateTime(2021, 03, 25, 08, 00),
      repeatAfter: Duration(days: 1),
    ),
    Reminder(
      id: 4,
      title: "CSC 667 Mid-Term",
      description: "Start preparing for CSC 667 Mid-Term Exam",
      category: Category(title: "College", color: Colors.black),
      dateTime: DateTime(2021, 04, 07, 12, 00),
      timeToBeNotified: DateTime(2021, 03, 27, 08, 00),
      repeatAfter: Duration(days: 1),
    )
  ];

  static final AllReminders _allReminders = AllReminders._internal();

  factory AllReminders() {
    return _allReminders;
  }

  AllReminders._internal();
}
