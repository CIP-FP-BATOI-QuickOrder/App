import 'package:quick_order/models/restaurant.dart';
import 'package:quick_order/models/user.dart';

import 'order_line.dart';

class Order {
  int id;
  User user;
  Restaurant restaurant;
  double price;
  int deliveryAddress;
  int deliveryTime;
  int discount;
  List<OrderLine> lines;

  Order(
      {required this.id,
      required this.user,
      required this.restaurant,
      required this.price,
      required this.deliveryTime,
      required this.deliveryAddress,
      required this.discount,
      required this.lines});
}
