import 'package:quick_order/models/payment_method.dart';

import 'address.dart';

class User {
  int id;
  String name;
  String surname;
  String email;
  String password;
  String phone;
  int credit;
  String photo;
  List<PaymentMethod> paymentMethods;
  List<Address> addresses;

  User(
      {required this.id,
      required this.name,
      required this.surname,
      required this.email,
      required this.password,
      required this.phone,
      required this.credit,
      required this.photo,
      required this.addresses,
      required this.paymentMethods});

  factory User.fromJson(Map<String, dynamic> map) {
    List<PaymentMethod> paymentMethodsList = [];
    List<Address> addressesList = [];

    if (map['paymentMethods'] != null) {
      var paymentMethodsData = map['paymentMethods'] as List;
      paymentMethodsList = paymentMethodsData.map((paymentMethod) => PaymentMethod.fromJson(paymentMethod)).toList();
    }

    if (map['addresses'] != null) {
      var addressesData = map['addresses'] as List;
      addressesList = addressesData.map((address) => Address.fromJson(address)).toList();
    }

    return User(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      email: map['email'],
      password: map['password'],
      phone: map['phone'],
      credit: map['credit'],
      photo: map['photo'],
      addresses: addressesList,
      paymentMethods: paymentMethodsList,
    );
  }
}
