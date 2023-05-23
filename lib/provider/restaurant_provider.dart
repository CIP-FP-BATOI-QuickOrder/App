import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/models/restaurant_list.dart';
import 'package:http/http.dart' as http;
import 'package:quick_order/provider/response_state.dart';
import 'package:quick_order/provider/user_provider.dart';

import '../models/restaurant.dart';
import '../models/user.dart';
import '../routes/routes.dart';

class RestaurantListProvider extends ChangeNotifier {
  RestaurantListProvider(this.context) {
    _getListRestaurant();
    _getPopularRestaurants();
    _getFavoritesRestaurants();
  }

  RestaurantList? _restaurantList;
  ResponseState? _responseState;
  late String _message = '';

  RestaurantList? get restaurantList => _restaurantList;
  ResponseState? get state => _responseState;
  String get message => _message;
  dynamic get refreshData => _getListRestaurant();

  Future<dynamic> _getListRestaurant() async {
    try {
      _responseState = ResponseState.loading;
      notifyListeners();
      final response = await http.get(Uri.parse("${Routes.api}restaurant/rand=10"));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<Restaurant> restaurants = [];
        for (var item in jsonData) {
          Restaurant restaurant = Restaurant.fromJson(item);
          restaurants.add(restaurant);
        }
        RestaurantList restaurantList = RestaurantList(
            restaurants: restaurants);
        if (restaurantList.restaurants.toString() == "") {
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
      return _message = 'Failed to get Data, Please check your connectivity';
    }
  }

  RestaurantList? _restaurantPopularList;
  ResponseState? _responsePopularState;
  late String _popularMessage = '';

  RestaurantList? get popularList => _restaurantPopularList;
  ResponseState? get popularState => _responsePopularState;
  String get popularMessage => _popularMessage;
  dynamic get refreshPopularData => _getPopularRestaurants();

  Future<dynamic> _getPopularRestaurants() async {
    try {
      _responsePopularState = ResponseState.loading;
      notifyListeners();
      final response = await http.get(Uri.parse("${Routes.api}restaurant/popular=10"));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<Restaurant> restaurants = [];
        for (var item in jsonData) {
          Restaurant restaurant = Restaurant.fromJson(item);
          restaurants.add(restaurant);
        }
        RestaurantList restaurantList = RestaurantList(
            restaurants: restaurants);
        if (restaurantList.restaurants.toString() == "") {
          _responsePopularState = ResponseState.noData;
          notifyListeners();
          return _popularMessage = 'Empty Data';
        } else {
          _responsePopularState = ResponseState.hasData;
          notifyListeners();
          return _restaurantPopularList = restaurantList;
        }
      }
    } catch (e) {
      _responseState = ResponseState.error;
      notifyListeners();
      return _message = 'Failed to get Data, Please check your connectivity';
    }
  }

  RestaurantList? _restaurantFavoritesList;
  ResponseState? _responseFavoritesState;
  late String _favoritesMessage = '';

  RestaurantList? get favoritesList => _restaurantFavoritesList;
  ResponseState? get favoritesState => _responseFavoritesState;
  String get favoritesMessage => _favoritesMessage;
  dynamic get refreshFavoritesData => _getFavoritesRestaurants();

  final BuildContext? context;

  User? getUser() {
    final userProvider = Provider.of<UserProvider>(context!);
    return userProvider.user;
  }

  Future<dynamic> _getFavoritesRestaurants() async {
    try {
      _responseFavoritesState = ResponseState.loading;
      notifyListeners();

      final response = await http.get(Uri.parse("${Routes.api}restaurant/favorites=21"));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<Restaurant> restaurants = [];
        for (var item in jsonData) {
          Restaurant restaurant = Restaurant.fromJson(item);
          restaurants.add(restaurant);
        }
        RestaurantList restaurantList = RestaurantList(
            restaurants: restaurants);
        if (restaurantList.restaurants.toString() == "") {
          _responseFavoritesState = ResponseState.noData;
          notifyListeners();
          return _favoritesMessage = 'Empty Data';
        } else {
          _responseFavoritesState = ResponseState.hasData;
          notifyListeners();
          return _restaurantFavoritesList = restaurantList;
        }
      }else{
        _responseState = ResponseState.error;
        notifyListeners();
        return _message = 'Failed to get Data, Please check your connectivity';
      }
    } catch (e) {
      _responseState = ResponseState.error;
      notifyListeners();
      return _message = 'Failed to get Data, Please check your connectivity';
    }
  }
}
