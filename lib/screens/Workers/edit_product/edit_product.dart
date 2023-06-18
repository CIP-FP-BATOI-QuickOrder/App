import 'package:flutter/material.dart';
import 'package:quick_order/provider/worker_restaurant_provider.dart';
import 'edit_product_content.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen({super.key, required this.provider, required this.id});
  WorkerRestaurantProvider provider;
  int id;

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
            child: EditProductContent(provider: provider, product: provider.getById(id)),
          ),
        ),
      ),
    );
  }
}
