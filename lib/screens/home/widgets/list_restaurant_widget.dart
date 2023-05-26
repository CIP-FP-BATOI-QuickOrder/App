import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/screens/home/widgets/restaurant_card_widget.dart';

import '../../../models/user.dart';
import '../../../provider/response_state.dart';
import '../../../provider/restaurant_provider.dart';
import '../../../provider/user_provider.dart';
import '../../../routes/routes.dart';

class ListRestaurant extends StatelessWidget {
  final RestaurantListProvider restaurantListProvider;

  const ListRestaurant({
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
    if (restaurantListProvider.state == ResponseState.loading) {
      return const Center(child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
      ));
    } else if (restaurantListProvider.state == ResponseState.error) {
      return Center(child: Text(restaurantListProvider.message));
    } else if (restaurantListProvider.state == ResponseState.noData) {
      return Center(child: Text(restaurantListProvider.message));
    } else if (restaurantListProvider.state == ResponseState.hasData) {
      var restaurants = restaurantListProvider.restaurantList!.restaurants;

      return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 250),
        child: ListView.builder(
          itemCount: restaurants.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  _,
                  Routes.restaurantDetailScreen,
                  arguments: restaurants[index],
                ).then((value) => restaurantListProvider.refreshData);
              },
              onLongPress: () => restaurantListProvider.refreshData,
              borderRadius: BorderRadius.circular(25),
              child: RestaurantCardWidget(
                id: restaurants[index].id,
                name: restaurants[index].name,
                city: restaurants[index].city,
                pictureId: restaurants[index].photo,
                deliveryPrice: restaurants[index].deliveryPrice,
                deliveryTime: restaurants[index].deliveryTime,
                tags: restaurants[index].tags,
                rating: restaurants[index].rating,
                userId: getUser()!.id,
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
