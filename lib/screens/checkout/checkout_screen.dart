import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/provider/products_provider.dart';
import 'package:quick_order/routes/routes.dart';
import 'package:quick_order/screens/checkout/widgets/list_order_widget.dart';
import 'package:quick_order/screens/profile/addresses/widget/list_address_widget.dart';
import 'package:quick_order/screens/profile/payment/widget/list_payment_widget.dart';

import '../../../provider/user_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key, required this.provider}) : super(key: key);
  final ProductsProvider provider;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          title: const Text("Your order"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListOrderWidget(
                    provider: widget.provider,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
