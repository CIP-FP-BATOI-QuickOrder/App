class PaymentMethod {
  int id;
  String creditCart;
  String expirationDate;
  String bank;
  String name;

  PaymentMethod(
      {required this.id,
      required this.bank,
      required this.creditCart,
      required this.expirationDate,
      required this.name});

  factory PaymentMethod.fromJson(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'],
      bank: map['bank'],
      creditCart: map['creditCart'],
      expirationDate: map['expirationDate'],
      name: map['name']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creditCart': creditCart,
      'expirationDate': expirationDate,
      'bank': bank,
      'name': name,
    };
  }
}
