import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/extensions/in_progress.dart';
import 'package:quick_order/models/order.dart';
import 'package:quick_order/models/order_line.dart';
import 'package:quick_order/models/restaurant.dart';
import 'package:quick_order/screens/restaurant_detail/widget/list_product_widget.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../../models/user.dart';
import '../../provider/Products_provider.dart';
import '../../provider/databaseHelper.dart';
import '../../provider/response_state.dart';
import '../../provider/user_provider.dart';
import '../../routes/routes.dart';
import '../welcome/widgets/signing_button.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final Restaurant restaurant;
  final int userId;

  const RestaurantDetailScreen({
    super.key,
    required this.restaurant,
    required this.userId,
  });

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  bool _isFavorite = false;
  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    _databaseHelper = DatabaseHelper();
    isFavorite();
    _databaseHelper.addRestaurant(widget.restaurant);
    super.initState();
  }

  Future<bool> addToFavorites() async {
    final response = await http.get(Uri.parse(
        "${Routes.api}favorites/add/user=${widget.userId}/restaurant=${widget.restaurant.id}"));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> removeFromFavorites() async {
    final response = await http.get(Uri.parse(
        "${Routes.api}favorites/remove/user=${widget.userId}/restaurant=${widget.restaurant.id}"));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void isFavorite() async {
    final response = await http.get(Uri.parse(
        "${Routes.api}favorites/user=${widget.userId}/restaurant=${widget.restaurant.id}"));
    if (response.statusCode == 200) {
      setState(() {
        _isFavorite = true;
      });
    } else {
      setState(() {
        _isFavorite = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    List<OrderLine> lines = [];
    Order order = Order(
      id: 0,
      userId: widget.userId,
      restaurantId: widget.restaurant.id,
      raiderId: 0,
      price: 0,
      deliveryTime: widget.restaurant.deliveryTime,
      deliveryAddress: 0,
      discount: 0,
      lines: lines,
    );

    return ChangeNotifierProvider<ProductsProvider>(
      create: (context) =>
          ProductsProvider(restaurant: widget.restaurant, order: order),
      child: Consumer<ProductsProvider>(
        builder: (context, productProvider, _) {
          if (productProvider.state == ResponseState.loading) {
            return const Scaffold(
              body: SafeArea(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (productProvider.state == ResponseState.noData) {
            return _detailError(context, productProvider.message);
          } else if (productProvider.state == ResponseState.error) {
            return _detailError(context, productProvider.message);
          } else if (productProvider.state == ResponseState.hasData) {
            return _detailRestaurant(context, productProvider);
          } else {
            return _detailError(context, productProvider.message);
          }
        },
      ),
    );
  }

  Widget _detailError(BuildContext context, String message) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/notfound.png',
                width: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  message != '' ? message : 'Empty Data',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 4,
                  vertical: 20,
                ),
                child: ButtonWidget(
                  onPress: () => Navigator.pop(context),
                  title: 'Back',
                  buttonColor: Colors.orange,
                  titleColor: Colors.white,
                  borderColor: Colors.orange,
                  paddingHorizontal: 0.0,
                  paddingVertical: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRestaurant(BuildContext context, ProductsProvider provider) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            onPressed: () {
              // Acción al hacer clic en el botón del carrito
            },
            backgroundColor: Colors.orange,
            child: const Icon(Icons.shopping_cart, color: Colors.white),
          ),
          Positioned(
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 10,
              child: Text(
                "${provider.order.lines.length}",
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: 200,
                        child: FutureBuilder(
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return const Text('Error loading image');
                            } else {
                              return Image.network(
                                '${Routes.apache}${provider.restaurant.photo}',
                                fit: BoxFit.fill,
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigator.pushNamedAndRemoveUntil(
                                //     context,
                                //     Routes.homeScreen,
                                //     (Route<dynamic> route) => false);
                                Navigator.pop(context, true);
                              },
                              enableFeedback: false,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: Colors.orange,
                              onTap: () async {
                                if (!_isFavorite) {
                                  addToFavorites();
                                  context.showCustomFlashMessage(
                                    status: 'success',
                                    title: 'Success Add Favorite',
                                    positionBottom: false,
                                    message:
                                        'Add ${widget.restaurant.name} to your Favorite',
                                  );
                                } else {
                                  removeFromFavorites();
                                  context.showCustomFlashMessage(
                                    status: 'success',
                                    title: 'Success remove Favorite',
                                    positionBottom: false,
                                    message:
                                        'Add ${widget.restaurant.name} to your Favorite',
                                  );
                                }
                                setState(() {
                                  _isFavorite = !_isFavorite;
                                });
                              },
                              child: _isFavorite
                                  ? Card(
                                      color: Colors.orange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  : Card(
                                      color: Colors.grey.withOpacity(0.5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28.0),
                  Text(
                    provider.restaurant.name,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                        shadows: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 5,
                            color: Colors.yellow,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      const SizedBox(width: 6.0),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          provider.restaurant.rating.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 2.0),
                      //   child: Text(
                      //     '(${provider.customerReviews!.length}+)',
                      //     style: const TextStyle(
                      //       fontSize: 15,
                      //       color: Colors.grey,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(width: 8.0),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: InkWell(
                          onTap: () {
                            // Navigator.pushNamed(
                            //   context,
                            //   Routes.restaurantReviewScreen,
                            //   arguments: restaurant.id,
                            // ).then((res) => checkRestaurantFavorite());
                          },
                          child: const Text(
                            'See Review',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.orange,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.orange,
                              decorationThickness: 1.3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: Colors.orange,
                        size: 20,
                        shadows: [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 5,
                            color: Colors.yellow,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      const SizedBox(width: 6.0),
                      Flexible(
                        child: Text(
                          '${provider.restaurant.direction}, ${provider.restaurant.city}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  ListProduct(
                    productProvider: provider,
                    context: context,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
