import 'package:flutter/material.dart';
import 'package:quick_order/models/payment_method.dart';
import '../models/address.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? user;

  void setUser(User user) {
    this.user = user;
    notifyListeners();
  }
  void deleteAddressById(int id){
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

  void deletePaymentById(int id){
    user!.paymentMethods.removeWhere((element) => element.id == id);
    notifyListeners();
  }
  PaymentMethod getPaymentById(int id){
    return user!.paymentMethods.singleWhere((element) => element.id == id);
  }
  bool updatePaymentById(PaymentMethod paymentMethod){
    user!.paymentMethods.removeWhere((element) => element.id == paymentMethod.id);
    notifyListeners();
    user!.paymentMethods.add(paymentMethod);
    notifyListeners();
    return true;
  }
}