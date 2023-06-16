import 'package:flutter/material.dart';
import 'package:quick_order/provider/user_provider.dart';
import 'package:quick_order/screens/checkout/shipping_dates/widgets/payment/payment_checkout_card_widget.dart';

class ListPaymentCheckoutWidget extends StatefulWidget {
  ListPaymentCheckoutWidget({
    Key? key,
    required this.userProvider,
    required this.selectedPaymentIndex,
    required this.onPaymentSelected, // Agrega esta línea
  }) : super(key: key);

  final UserProvider userProvider;
  int selectedPaymentIndex;
  final Function(int) onPaymentSelected; // Agrega esta línea

  @override
  _ListPaymentCheckoutWidgetState createState() =>
      _ListPaymentCheckoutWidgetState();
}

class _ListPaymentCheckoutWidgetState extends State<ListPaymentCheckoutWidget> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 100),
      child: ListView.builder(
        itemCount: widget.userProvider.user!.paymentMethods.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              setState(() {
                widget.selectedPaymentIndex = index;
              });
              widget.onPaymentSelected(index); // Agrega esta línea
            },
            child: PaymentCheckoutCardWidget(
              expirationDate: widget.userProvider.user!.paymentMethods[index].expirationDate,
              creditCart: widget.userProvider.user!.paymentMethods[index].creditCart,
              bank: widget.userProvider.user!.paymentMethods[index].bank,
              name: widget.userProvider.user!.paymentMethods[index].name,
              id: widget.userProvider.user!.paymentMethods[index].id,
              isSelected: index == widget.selectedPaymentIndex,
            ),
          );
        },
      ),
    );
  }
}

