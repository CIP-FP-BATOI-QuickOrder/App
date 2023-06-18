import 'package:flutter/material.dart';
import 'package:quick_order/provider/worker_restaurant_provider.dart';
import 'new_product_content.dart';

class NewProductScreen extends StatelessWidget {
  NewProductScreen({super.key, required this.provider});
  WorkerRestaurantProvider provider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Product edit")),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: NewProductContent(provider: provider),
          ),
        ),
      ),
    );
  }
}
