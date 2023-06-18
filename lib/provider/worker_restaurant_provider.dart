import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_order/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:quick_order/provider/response_state.dart';
import '../models/product.dart';
import '../routes/routes.dart';
import 'package:path/path.dart' as path;

class WorkerRestaurantProvider with ChangeNotifier {
  late Restaurant restaurant;
  late List<Product> products;
  ResponseState? responseState;
  late String message = '';

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
      if (await getProducts()) {
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  Future<void> resetPassword(String nif, String password) async {
    final response = await http.post(
        Uri.parse("${Routes.api}restaurant/reset/nif=$nif/password=$password"));
    if (response.statusCode == 200) {
      restaurant = Restaurant.fromJson(jsonDecode(response.body));
      notifyListeners();
    }
  }

  Future<bool> getProducts() async {
    try {
      products = [];
      responseState = ResponseState.loading;
      notifyListeners();

      final response = await http
          .get(Uri.parse("${Routes.api}product/restaurant=${restaurant.id}"));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<Product> products = [];
        for (var item in jsonData) {
          Product product = Product.fromJson(item);
          products.add(product);
        }

        if (products.isEmpty) {
          responseState = ResponseState.noData;
          notifyListeners();
          message = 'Empty Data';
        } else {
          responseState = ResponseState.hasData;
          notifyListeners();
          this.products = products;
          notifyListeners();
        }
      }
    } catch (e) {
      responseState = ResponseState.error;
      notifyListeners();
      message = 'Failed to get Data, Please check your connectivity';
      return false;
    }
    return true;
  }

  Future<bool> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse("${Routes.api}product/$id"));

    if (response.statusCode == 200) {
      products.removeWhere((element) => element.id == id);
      notifyListeners();
      return true;
    }
    return false;
  }

  Product getById(int id) {
    return products.firstWhere((element) => element.id == id);
  }

  Future<void> updateProduct(Product product) async {
    Map<String, dynamic> productJson = product.toJson();
    await http.post(
      Uri.parse("${Routes.api}product/${product.id}"),
      body: jsonEncode(productJson),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<void> upgradeProductPhoto(PickedFile pickedFile, int id) async {
    final request = http.MultipartRequest(
        'POST', Uri.parse("${Routes.api}product/upload=$id"));
    final fileMultipart = await http.MultipartFile.fromPath(
        'photo', pickedFile.path,
        contentType: MediaType('image', 'jpeg'));

    request.files.add(fileMultipart);

    await request.send();
    Product product = getById(id);
    product.photo = path.basename(pickedFile.path);
    notifyListeners();
  }

  Future<void> saveProduct(Product product, PickedFile file) async {
    Map<String, dynamic> productJson = product.toJson();
   final response = await http.post(
      Uri.parse("${Routes.api}product/restaurant=${restaurant.id}"),
      body: jsonEncode(productJson),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201){
      product.id = int.parse(response.body);
      upgradeProductPhoto(file, product.id);
      products.add(product);
      notifyListeners();
    }
  }
}
