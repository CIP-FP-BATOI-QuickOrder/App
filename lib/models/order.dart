import 'order_line.dart';

class Order {
  int id;
  int userId;
  int restaurantId;
  int raiderId;
  double price;
  int deliveryAddress;
  int deliveryTime;
  int discount;
  List<OrderLine> lines;

  Order(
      {required this.id,
      required this.userId,
      required this.restaurantId,
      required this.raiderId,
      required this.price,
      required this.deliveryTime,
      required this.deliveryAddress,
      required this.discount,
      required this.lines});
}
