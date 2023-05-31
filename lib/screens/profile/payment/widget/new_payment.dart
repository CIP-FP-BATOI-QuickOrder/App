import 'package:flutter/material.dart';
import 'package:quick_order/provider/user_provider.dart';
import 'package:quick_order/screens/profile/payment/widget/new_payment_content.dart';

class NewPaymentScreen extends StatelessWidget {
  NewPaymentScreen({super.key, required this.userProvider});
  UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: NewPaymentContent(userProvider: userProvider),
          ),
        ),
      ),
    );
  }
}
