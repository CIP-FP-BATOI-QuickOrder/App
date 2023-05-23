import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/screens/home/widgets/list_favorites_widget.dart';

import '../../provider/restaurant_provider.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
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

    return RefreshIndicator(
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
                  child: ListFavoritesRestaurant(
                    restaurantListProvider: restaurantListProvider,
                    context: context,
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
