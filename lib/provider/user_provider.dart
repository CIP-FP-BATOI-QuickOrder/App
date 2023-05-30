import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? user;

  void setUser(User user) {
    this.user = user;
    notifyListeners();
  }
  void deleteById(int id){
    user!.addresses.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}