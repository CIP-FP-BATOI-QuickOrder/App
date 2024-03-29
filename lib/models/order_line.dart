import 'package:quick_order/models/product.dart';

class OrderLine {
  int id;
  Product product;
  int qty;
  double price;
  double unitPrice;

  OrderLine(
      {required this.price,
      required this.qty,
      required this.id,
      required this.product,
      required this.unitPrice});

  Map<String, dynamic> toJson() {
    return {
      'orderLineId': {
        'id': 1,
        'orderId': 1,
      },
      'qty': qty,
      'price': price,
      'unitPrice': unitPrice,
    };
  }
}
