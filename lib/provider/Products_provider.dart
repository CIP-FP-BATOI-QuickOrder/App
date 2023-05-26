import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quick_order/provider/response_state.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/restaurant.dart';
import '../routes/routes.dart';


class ProductsProvider extends ChangeNotifier {
  ProductsProvider({required this.restaurant}) {
    _getDetailRestaurant();
  }

  List<Product>? _products;
  ResponseState? _responseState;
  late String _message = '';
  Restaurant restaurant;

  List<Product>? get products => _products;
  ResponseState? get state => _responseState;
  String get message => _message;
  dynamic get refreshData {
    _getDetailRestaurant();
    notifyListeners();
    return;
  }

  Future<dynamic> _getDetailRestaurant() async {
    try {
      _responseState = ResponseState.loading;
      notifyListeners();

      final response = await http.get(Uri.parse("${Routes.api}product/restaurant=${restaurant.id}"));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<Product> products = [];
        for (var item in jsonData) {
          Product product = Product.fromJson(item);
          products.add(product);
        }

        if (products.isEmpty) {
          _responseState = ResponseState.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _responseState = ResponseState.hasData;
          notifyListeners();
          return _products = products;
        }
      }
    } catch (e) {
      _responseState = ResponseState.error;
      notifyListeners();
      return _message = 'Failed to get Data, Please check your connectivity';
    }
  }
}
