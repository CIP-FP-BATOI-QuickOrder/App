import 'package:quick_order/models/restaurant.dart';
import 'package:quick_order/models/user.dart';

class Review {
  int id;
  User user;
  Restaurant restaurant;
  String content;
  DateTime createdAt;

  Review(
      {required this.restaurant,
      required this.user,
      required this.id,
      required this.content,
      required this.createdAt});

  factory Review.fromJson(Map<String, dynamic> map) {
      User user = User.fromJson(map['user']);
      Restaurant restaurant = Restaurant.fromJson(map['restaurant']);

    return Review(
      id: map['id'],
      user: user,
      content: map['content'],
      createdAt: DateTime.parse(map['createdAt']) ,
      restaurant: restaurant
    );
  }
}
