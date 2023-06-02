import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quick_order/models/review.dart';
import 'package:quick_order/provider/response_state.dart';
import 'package:http/http.dart' as http;

import '../models/restaurant.dart';
import '../routes/routes.dart';


class ReviewProvider extends ChangeNotifier {
  ReviewProvider({required this.restaurant}) {
    _getReviews();
  }

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
}
