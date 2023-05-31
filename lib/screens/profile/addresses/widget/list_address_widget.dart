import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/provider/user_provider.dart';
import 'package:quick_order/screens/profile/addresses/widget/address_cart_widget.dart';

class ListAddressWidget extends StatelessWidget {
  const ListAddressWidget({super.key, required this.userProvider});
  final UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size.height - 60),
      child: ListView.builder(
        itemCount: userProvider.user!.addresses.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (_, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(25),
            child: AddressCardWidget(
              userProvider: userProvider,
              id: userProvider.user!.addresses[index].id,
              name: userProvider.user!.addresses[index].name,
              city: userProvider.user!.addresses[index].city,
              cp: userProvider.user!.addresses[index].cp,
              number: userProvider.user!.addresses[index].number,
              address: userProvider.user!.addresses[index].address,
              addressName: userProvider.user!.addresses[index].addressName,
            ),
          );
        },
      ),
    );
  }
}
