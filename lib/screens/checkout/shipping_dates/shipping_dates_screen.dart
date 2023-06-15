import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/provider/products_provider.dart';
import 'package:quick_order/routes/routes.dart';
import 'package:quick_order/screens/checkout/shipping_dates/widgets/address/list_address_checkout_widget.dart';
import 'package:quick_order/screens/checkout/shipping_dates/widgets/payment/list_payment_checkout_widget.dart';
import 'package:quick_order/screens/checkout/widgets/list_order_widget.dart';
import 'package:quick_order/screens/profile/addresses/widget/list_address_widget.dart';
import 'package:quick_order/screens/profile/payment/widget/list_payment_widget.dart';

import '../../../provider/user_provider.dart';
import '../../home/search_screen.dart';
import '../../home/widgets/search_form_field.dart';

class ShippingDatesScreen extends StatefulWidget {
  const ShippingDatesScreen({Key? key, required this.provider})
      : super(key: key);
  final ProductsProvider provider;

  @override
  State<ShippingDatesScreen> createState() => _ShippingDatesScreenState();
}

class _ShippingDatesScreenState extends State<ShippingDatesScreen> {
  int selectedAddressIndex = -1;
  int selectedPaymentIndex = -1;
  TextEditingController discountController = TextEditingController();
  @override
  void initState() {
    widget.provider.calcPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final deliveryPrice = widget.provider.restaurant.deliveryPrice == 0
        ? "Free"
        : "${widget.provider.restaurant.deliveryPrice} €";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: Text(
                          'Shipping address',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, Routes.newAddress),
                                child: const Text(
                                  'New address',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.orange,
                                  ),
                                ),
                              )),
                          const Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.orange,
                            size: 18,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ListAddressCheckoutWidget(
                    userProvider: Provider.of<UserProvider>(context),
                    selectedAddressIndex: selectedAddressIndex,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: Text(
                          'Payment method',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, Routes.newPayment),
                                child: const Text(
                                  'New payment method',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.orange,
                                  ),
                                ),
                              )),
                          const Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.orange,
                            size: 18,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  ListPaymentCheckoutWidget(
                    userProvider: Provider.of<UserProvider>(context),
                    selectedPaymentIndex: selectedPaymentIndex,
                  ),
                  const SizedBox(height: 35.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FormFieldWidget(
                          hintText: 'Discount code',
                          controller: discountController,
                          onSubmitted: (p0) {
                            Navigator.pushNamed(
                              context,
                              Routes.restaurantSearchScreen,
                              arguments: p0,
                            ).then(
                                (value) => widget.provider.refreshData);
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 14.0),
                      InkWell(
                        onTap: () {

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
                              Icons.discount_outlined,
                              color: Colors.orange,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Subtotal'),
                      Text(
                          "${widget.provider.order.price.toStringAsFixed(2)} €")
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tax 21%'),
                      Text(
                          "${(widget.provider.order.price * 0.21).toStringAsFixed(2)} €")
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Delivery price'),
                      Text(deliveryPrice)
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  const Divider(
                    color: Colors.black,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total'),
                      Text(
                          "${widget.provider.calcFinalPrice().toStringAsFixed(2)} €")
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          width: 1.0,
                          color: Colors.orange,
                        ),
                        backgroundColor: Colors.orange,
                        alignment: Alignment.center,
                        shadowColor: Colors.black26,
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 35,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Container(
                        width: size.width, // Ancho completo de la pantalla
                        child: const Text(
                          "Pay",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
