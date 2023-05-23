import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/screens/home/widgets/restaurant_card_widget.dart';
import 'package:quick_order/screens/home/widgets/restaurant_search_card_widget.dart';

import '../../../models/user.dart';
import '../../../provider/response_state.dart';
import '../../../provider/restaurant_provider.dart';
import '../../../provider/user_provider.dart';
import '../../../routes/routes.dart';

class ListFavoritesRestaurant extends StatelessWidget {
  final RestaurantListProvider restaurantListProvider;

  const ListFavoritesRestaurant({
    super.key,
    required this.restaurantListProvider, required this.context,
  });
  final BuildContext? context;

  User? getUser() {
    final userProvider = Provider.of<UserProvider>(context!);
    return userProvider.user;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (restaurantListProvider.favoritesState == ResponseState.loading) {
      return const Center(child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
      ));
    } else if (restaurantListProvider.state == ResponseState.error) {
      return Center(child: Text(restaurantListProvider.favoritesMessage));
    } else if (restaurantListProvider.favoritesState == ResponseState.noData) {
      return Center(child: Text(restaurantListProvider.favoritesMessage));
    } else if (restaurantListProvider.favoritesState == ResponseState.hasData) {
      var restaurants = restaurantListProvider.favoritesList!.restaurants;

      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: size.height),
        child: ListView.builder(
          itemCount: restaurants.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  _,
                  Routes.restaurantDetailScreen,
                  arguments: restaurants[index].id,
                ).then((value) => restaurantListProvider.refreshFavoritesData);
              },
              onLongPress: () => restaurantListProvider.refreshFavoritesData,
              borderRadius: BorderRadius.circular(25),
              child: RestaurantSearchCardWidget(
                name: restaurants[index].name,
                city: restaurants[index].city,
                pictureId: restaurants[index].photo,
              ),
            );
          },
        ),
      );
    } else {
      return Center(child: Text(restaurantListProvider.message));
    }
  }
}
