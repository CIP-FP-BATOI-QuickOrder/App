import 'package:flutter/material.dart';
import '../models/address.dart';
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
  Address getAddressById(int id){
    return user!.addresses.singleWhere((element) => element.id == id);
  }
  bool updateAddressById(Address address){
    user!.addresses.removeWhere((element) => element.id == address.id);
    user!.addresses.add(address);
    notifyListeners();
    return true;
  }
}