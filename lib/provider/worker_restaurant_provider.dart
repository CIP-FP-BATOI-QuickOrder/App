import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_order/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../models/product.dart';
import '../routes/routes.dart';

class WorkerRestaurantProvider with ChangeNotifier {
  late Restaurant restaurant;
  late List<Product> products;

  Future<bool> register(Restaurant restaurant) async {
    this.restaurant = restaurant;

    Map<String, dynamic> restaurantJson = restaurant.toJson();

    final response = await http.post(
      Uri.parse("${Routes.api}restaurant"),
      body: jsonEncode(restaurantJson),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      this.restaurant.id = int.parse(response.body);
      upgradeTags();
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> upgradePhoto(PickedFile pickedFile) async {
    final request = http.MultipartRequest(
        'POST', Uri.parse("${Routes.api}restaurant/upload=${restaurant.id}"));
    final fileMultipart = await http.MultipartFile.fromPath(
        'photo', pickedFile.path,
        contentType: MediaType('image', 'jpeg'));

    request.files.add(fileMultipart);

    await request.send();
  }

  Future<void> upgradeTags() async {
    for (String tag in restaurant.tags) {
      await http
          .post(Uri.parse("${Routes.api}tag/$tag/restaurant=${restaurant.id}"));
    }
  }

  Future<bool> login(String nif, String password) async {
    final response = await http
        .get(Uri.parse("${Routes.api}restaurant/nif=$nif/password=$password"));
    if (response.statusCode == 200) {
      restaurant = Restaurant.fromJson(jsonDecode(response.body));
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> resetPassword(String nif, String password) async {
    final response = await http
        .post(Uri.parse("${Routes.api}restaurant/reset/nif=$nif/password=$password"));
    if (response.statusCode == 200) {
      restaurant = Restaurant.fromJson(jsonDecode(response.body));
      notifyListeners();
    }
  }
}
