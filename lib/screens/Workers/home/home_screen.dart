import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/provider/worker_restaurant_provider.dart';
import 'package:quick_order/screens/Workers/home/widgets/product_cart_widget.dart';
import 'package:quick_order/screens/home/widgets/restaurant_search_card_widget.dart';

import '../../../provider/response_state.dart';
import '../../../routes/routes.dart';
import '../../restaurant_detail/widget/product_cart_widget.dart';

class WorkersHomeScreen extends StatefulWidget {
  final WorkerRestaurantProvider provider;

  const WorkersHomeScreen({
    super.key,
    required this.provider,
  });

  @override
  State<WorkersHomeScreen> createState() => _WorkersHomeScreenState();
}

class _WorkersHomeScreenState extends State<WorkersHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.provider.restaurant.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: _getSearchData()),
            ],
          ),
        ),
      ),
    );
  }

  _getSearchData() {
    var products = widget.provider.products;

    Future<bool> deleteProduct(int id) async {
      if (await widget.provider.deleteProduct(id)){
        setState(() {
          products = widget.provider.products;
        });

        return true;
      }
      return false;
    }
    if (products.isEmpty) {
      return NotFoundDataWidget(
        message: widget.provider.message.toString(),
      );
    } else {
      return ListView.builder(
        itemCount: products.length,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(16),
              child: WorkersProductCartWidget(
                photo: products[index].photo,
                name: products[index].name,
                description: products[index].description,
                price: products[index].price,
                provider: widget.provider,
                id: products[index].id,
                onDelete: (id) => deleteProduct(id),
              ));
        },
      );
    }
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
