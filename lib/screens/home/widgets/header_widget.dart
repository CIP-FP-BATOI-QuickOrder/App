import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/provider/restaurant_provider.dart';

import '../../../models/user.dart';
import '../../../provider/user_provider.dart';
import '../../../routes/routes.dart';
import 'current_city_widget.dart';

class HeaderWidget extends StatelessWidget {
  final RestaurantListProvider restaurantListProvider;

  const HeaderWidget({
    super.key,
    required this.restaurantListProvider,
    required this.context,
  });

  final BuildContext context;

  User? getUser() {
    final userProvider = Provider.of<UserProvider>(context);
    return userProvider.user;
  }

  @override
  Widget build(BuildContext context) {
    User? user = getUser();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, Routes.profileScreen),
          enableFeedback: false,
          borderRadius: BorderRadius.circular(14),
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error loading image');
              } else {
                return CircleAvatar(
                  backgroundImage: NetworkImage('${Routes.apache}${user?.photo}'),
                  radius: 25,
                );
              }
            },
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: const [
                  Text(
                    'Deliver to',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 22,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            const LocationPage(),
          ],
        ),
        InkWell(
          onTap: () =>
              Navigator.pushNamed(context, Routes.restaurantFavoriteScreen)
                  .then((value) => restaurantListProvider.refreshData),
          enableFeedback: false,
          splashColor: Colors.grey,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
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
                Icons.favorite,
                size: 20,
                color: Colors.orange,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
