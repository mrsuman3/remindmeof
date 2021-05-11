import 'dart:io';

class User {
  String email;
  String password;
  String fullName;
  DateTime dateOfBirth;
  File imageFile;

  static final User _user = User._internal();

  factory User() {
    return _user;
  }

  User._internal();
}
