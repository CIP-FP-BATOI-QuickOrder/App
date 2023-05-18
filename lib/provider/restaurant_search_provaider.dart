import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:quick_order/models/restaurant_list.dart';
import 'package:quick_order/provider/response_state.dart';
import 'package:http/http.dart' as http;

import '../models/restaurant.dart';
import '../routes/routes.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  RestaurantSearchProvider(id) {
    _searchRestaurant(id);
  }

  RestaurantList? _restaurantList;
  ResponseState? _responseState;
  late String _message = '';

  set queryValue(query) {
    _searchRestaurant(query);
    notifyListeners();
  }

  RestaurantList? get restaurantList => _restaurantList;
  ResponseState? get state => _responseState;
  String get message => _message;

  Future<dynamic> _searchRestaurant(id) async {
    try {
      _responseState = ResponseState.loading;
      notifyListeners();

      final response = await http.get(Uri.parse("${Routes.api}restaurant/search=$id"));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<Restaurant> restaurants = [];
        for (var item in jsonData) {
          Restaurant restaurant = Restaurant.fromJson(item);
          restaurants.add(restaurant);
        }
        RestaurantList restaurantList = RestaurantList(
            restaurants: restaurants);
        if (restaurantList.restaurants.isEmpty) {
          _responseState = ResponseState.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _responseState = ResponseState.hasData;
          notifyListeners();
          return _restaurantList = restaurantList;
        }
      }
    } catch (e) {
      _responseState = ResponseState.error;
      notifyListeners();
      return _message = 'Data Not Found';
    }
  }
}
