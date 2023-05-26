import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/provider/Products_provider.dart';
import 'package:quick_order/screens/restaurant_detail/widget/product_cart_widget.dart';

import '../../../models/user.dart';
import '../../../provider/response_state.dart';
import '../../../provider/user_provider.dart';
import '../../../routes/routes.dart';

class ListProduct extends StatelessWidget {
  final ProductsProvider productProvider;

  const ListProduct({
    super.key,
    required this.productProvider, required this.context,
  });

  final BuildContext? context;

  User? getUser() {
    final userProvider = Provider.of<UserProvider>(context!);
    return userProvider.user;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (productProvider.state == ResponseState.loading) {
      return const Center(child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
      ));
    } else if (productProvider.state == ResponseState.error) {
      return Center(child: Text(productProvider.message));
    } else if (productProvider.state == ResponseState.noData) {
      return Center(child: Text(productProvider.message));
    } else if (productProvider.state == ResponseState.hasData) {
      var products = productProvider.products;

      return ListView.builder(
        itemCount: products!.length,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              // Navigator.pushNamed(
              //   _,
              //   Routes.restaurantDetailScreen,
              //   arguments: restaurants[index],
              // );
            },
            borderRadius: BorderRadius.circular(16),
            child: ProductCartWidget(
              name: products![index].name,
              photo: products[index].photo,
              price: products[index].price,
              description: products[index].description,
            ),
          );
        },
      );
    } else {
      return Center(child: Text(productProvider.message));
    }
  }
}
