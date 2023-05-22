import 'package:flutter/material.dart';
import 'package:quick_order/screens/home/widgets/restaurant_card_widget.dart';

import '../../../provider/response_state.dart';
import '../../../provider/restaurant_provider.dart';
import '../../../routes/routes.dart';

class ListPopularRestaurant extends StatelessWidget {
  final RestaurantListProvider restaurantListProvider;

  const ListPopularRestaurant({
    super.key,
    required this.restaurantListProvider,
  });

  @override
  Widget build(BuildContext context) {
    if (restaurantListProvider.popularState == ResponseState.loading) {
      return const Center(child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
      ));
    } else if (restaurantListProvider.state == ResponseState.error) {
      return Center(child: Text(restaurantListProvider.popularMessage));
    } else if (restaurantListProvider.popularState == ResponseState.noData) {
      return Center(child: Text(restaurantListProvider.popularMessage));
    } else if (restaurantListProvider.popularState == ResponseState.hasData) {
      var restaurants = restaurantListProvider.popularList!.restaurants;

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
                  arguments: restaurants[index].id,
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
