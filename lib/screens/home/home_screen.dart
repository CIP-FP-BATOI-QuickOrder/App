import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/models/restaurant_list.dart';
import 'package:quick_order/screens/home/search_screen.dart';
import 'package:quick_order/screens/home/widgets/food_search_widget.dart';
import 'package:quick_order/screens/home/widgets/header_widget.dart';
import 'package:quick_order/screens/home/widgets/list_popular_restaurants_widget.dart';
import 'package:quick_order/screens/home/widgets/list_restaurant_widget.dart';

import '../../models/user.dart';
import '../../provider/restaurant_provider.dart';
import '../../provider/user_provider.dart';
import '../../routes/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchRestaurant;

  @override
  void initState() {
    super.initState();
    _searchRestaurant = TextEditingController();
  }

  @override
  void dispose() {
    _searchRestaurant.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantListProvider>(
      create: (context) => RestaurantListProvider(context),
      child: Consumer<RestaurantListProvider>(
        builder: (context, restaurantListProvider, _) {
          return _homeScreen(context, restaurantListProvider);
        },
      ),
    );
  }

  Widget _homeScreen(
      BuildContext context, RestaurantListProvider restaurantListProvider) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () => restaurantListProvider.refreshData,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
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
                        HeaderWidget(
                          restaurantListProvider: restaurantListProvider,
                        ),
                        const SizedBox(height: 32.0),
                        Image.asset(
                          'assets/images/home_title.png',
                          width: size.width - 120,
                        ),
                        const SizedBox(height: 16.0),
                        FoodSearchWidget(
                          searchRestaurant: _searchRestaurant,
                          restaurantListProvider: restaurantListProvider,
                        ),
                        const SizedBox(height: 18.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Flexible(
                              child: Text(
                                'Featured Restaurants',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SearchScreen(
                                                    query: ' ',
                                                  ))),
                                      child: const Text(
                                        'View All',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    )),
                                const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.orange,
                                  size: 18,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 18.0),
                        ListRestaurant(
                            restaurantListProvider: restaurantListProvider, context: context),
                        const SizedBox(height: 28.0),
                        const Text(
                          'Popular Items',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 18.0),
                        ListPopularRestaurant(
                            restaurantListProvider: restaurantListProvider, context: context,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
