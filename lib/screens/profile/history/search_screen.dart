import 'package:flutter/material.dart';
import 'package:quick_order/provider/databaseHelper.dart';
import 'package:quick_order/screens/home/widgets/restaurant_search_card_widget.dart';

import '../../../models/restaurant.dart';
import '../../../routes/routes.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    super.key,});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late DatabaseHelper _databaseHelper;
  late Future<List<Restaurant>> restaurants;

  @override
  void initState() {
    _databaseHelper = DatabaseHelper();
    restaurants = _databaseHelper.getRestaurants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: FutureBuilder<List<Restaurant>>(
                  future: restaurants,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final restaurantList = snapshot.data!;
                      return ListView.builder(
                        itemCount: restaurantList.length,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.restaurantDetailScreen,
                                arguments: restaurantList[index],
                              );
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: RestaurantSearchCardWidget(
                              name: restaurantList[index].name,
                              pictureId: restaurantList[index].photo,
                              city: restaurantList[index].city,
                              rating: restaurantList[index].rating,
                              deliveryPrice:
                                  restaurantList[index].deliveryPrice,
                              deliveryTime: restaurantList[index].deliveryTime,
                            ),
                          );
                        },
                      );
                    } else {
                      return const NotFoundDataWidget(message: 'Empty Data');
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NotFoundDataWidget extends StatelessWidget {
  final String message;

  const NotFoundDataWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: size.height / 8),
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
            Text(
              message != '' ? message : 'Empty Data',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
