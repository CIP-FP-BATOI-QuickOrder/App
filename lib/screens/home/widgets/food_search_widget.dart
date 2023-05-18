import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/provider/restaurant_provider.dart';
import 'package:quick_order/screens/home/widgets/search_form_field.dart';

import '../../../routes/routes.dart';

class FoodSearchWidget extends StatelessWidget {
  final TextEditingController searchRestaurant;
  final RestaurantListProvider restaurantListProvider;

  const FoodSearchWidget({
    Key? key,
    required this.searchRestaurant,
    required this.restaurantListProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FormFieldWidget(
            hintText: 'Find for Restaurants...',
            controller: searchRestaurant,
            onSubmitted: (p0) {
              Navigator.pushNamed(
                context,
                Routes.restaurantSearchScreen,
                arguments: p0,
              ).then((value) => restaurantListProvider.refreshData);
              return null;
            },
          ),
        ),
        const SizedBox(width: 14.0),
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.restaurantSearchScreen,
              arguments: searchRestaurant.text,
            ).then((value) => restaurantListProvider.refreshData);
          },
          splashColor: Colors.orange,
          borderRadius: BorderRadius.circular(12),
          enableFeedback: false,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ]),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2,
                vertical: 2,
              ),
              child: Icon(
                Icons.search,
                color: Colors.orange,
                size: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
