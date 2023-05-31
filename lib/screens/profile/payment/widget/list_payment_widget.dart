import 'package:flutter/material.dart';
import 'package:quick_order/provider/user_provider.dart';
import 'package:quick_order/screens/profile/payment/widget/payment_cart_widget.dart';

class ListPaymentWidget extends StatelessWidget {
  const ListPaymentWidget({super.key, required this.userProvider});
  final UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size.height - 60),
      child: ListView.builder(
        itemCount: userProvider.user!.paymentMethods.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (_, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(25),
            child: PaymentCardWidget(
              userProvider: userProvider,
              id: userProvider.user!.paymentMethods[index].id,
              name: userProvider.user!.paymentMethods[index].name,
              bank: userProvider.user!.paymentMethods[index].bank,
              creditCart: userProvider.user!.paymentMethods[index].creditCart,
              expirationDate: userProvider.user!.paymentMethods[index].expirationDate,
            ),
          );
        },
      ),
    );
  }
}
