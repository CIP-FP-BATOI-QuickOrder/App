import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/models/review.dart';
import 'package:quick_order/provider/response_state.dart';
import 'package:http/http.dart' as http;
import 'package:quick_order/provider/user_provider.dart';

import '../models/restaurant.dart';
import '../models/user.dart';
import '../routes/routes.dart';


class ReviewProvider extends ChangeNotifier {
  ReviewProvider({required this.restaurant, required this.user}) {
    _getReviews();
  }

  User user;
  List<Review>? _reviews;
  ResponseState? _responseState;
  late String _message = '';
  Restaurant restaurant;

  List<Review>? get reviews => _reviews;
  ResponseState? get state => _responseState;
  String get message => _message;
  dynamic get refreshData {
    _getReviews();
    notifyListeners();
    return;
  }

  Future<dynamic> _getReviews() async {
    try {
      _responseState = ResponseState.loading;
      notifyListeners();

      final response = await http.get(Uri.parse("${Routes.api}review/restaurant=${restaurant.id}"));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<Review> reviews = [];
        for (var item in jsonData) {
          Review review = Review.fromJson(item);
          reviews.add(review);
        }

        if (reviews.isEmpty) {
          _responseState = ResponseState.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _responseState = ResponseState.hasData;
          notifyListeners();
          return _reviews = reviews;
        }
      }
    } catch (e) {
      _responseState = ResponseState.error;
      notifyListeners();
      return _message = 'Failed to get Data, Please check your connectivity';
    }
  }

  Future<bool> sendReview(String content, double value) async {
    Review review = Review(
      restaurant: restaurant,
      user: user,
      id: 0,
      content: content,
      createdAt: DateTime.now(),
    );

    Map<String, dynamic> reviewJson = review.toJson();

    final response = await http.post(
      Uri.parse(
          "${Routes.api}review/user=${user.id}/restaurant=${restaurant.id}"),
      body: jsonEncode(reviewJson),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      reviews?.add(review);
      notifyListeners();


      final response2 = await http.post(
        Uri.parse(
            "${Routes.api}rating/user=${user.id}/restaurant=${restaurant.id}/content=$value"),
        headers: {'Content-Type': 'application/json'},
      );

      return true;
    }
    return false;
  }

}
