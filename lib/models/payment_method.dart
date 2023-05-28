class PaymentMethod {
  int id;
  String creditCart;
  String expirationDate;
  String bank;

  PaymentMethod(
      {required this.id,
      required this.bank,
      required this.creditCart,
      required this.expirationDate});

  factory PaymentMethod.fromJson(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'],
      bank: map['bank'],
      creditCart: map['creditCart'],
      expirationDate: map['expirationDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creditCart': creditCart,
      'expirationDate': expirationDate,
      'bank': bank,
    };
  }
}
