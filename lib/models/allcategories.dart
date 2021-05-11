import 'package:flutter/material.dart' show Colors;
import 'package:remindmeof/models/category.dart';

class AllCategories {
  List<Category> categories = [
    Category(title: "Birthday", color: Colors.red),
    Category(title: "Payment", color: Colors.blue),
    Category(title: "College", color: Colors.black),
  ];

  static final AllCategories _allCategories = AllCategories._internal();

  factory AllCategories() {
    return _allCategories;
  }

  AllCategories._internal();
}
