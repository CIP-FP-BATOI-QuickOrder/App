import 'package:flutter/material.dart';
import 'package:quick_order/provider/user_provider.dart';
import 'package:quick_order/screens/profile/addresses/edit_address/edit_address_content.dart';
import 'package:quick_order/screens/profile/addresses/widget/new_address_content.dart';

class NewAddressScreen extends StatelessWidget {
  NewAddressScreen({super.key, required this.userProvider});
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
            child: NewAddressContent(userProvider: userProvider),
          ),
        ),
      ),
    );
  }
}
