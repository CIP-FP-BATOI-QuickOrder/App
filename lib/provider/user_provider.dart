import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? user;

  void setUser(User user) {
    this.user = user;
    notifyListeners();
  }
}