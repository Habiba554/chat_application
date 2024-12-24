import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String phoneNumber = "";

  String get phoneNumbers => phoneNumber;

  void setPhoneNumber(String phone) {
    phoneNumber = phone;
    notifyListeners(); 
  }
}
