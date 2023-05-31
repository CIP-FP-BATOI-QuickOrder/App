import 'package:flutter/material.dart';
import 'package:quick_order/provider/user_provider.dart';
import 'package:quick_order/screens/profile/addresses/edit_address/edit_address_content.dart';
import 'package:quick_order/screens/profile/payment/edit_payment/edit_payment_content.dart';

class EditPaymentScreen extends StatelessWidget {
  EditPaymentScreen({super.key, required this.userProvider, required this.id});
  UserProvider userProvider;
  int id;

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
            child: EditPaymentContent(userProvider: userProvider, id: id),
          ),
        ),
      ),
    );
  }
}
