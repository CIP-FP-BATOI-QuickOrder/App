import 'package:flutter/material.dart';
import 'package:quick_order/provider/user_provider.dart';
import 'package:quick_order/screens/profile/addresses/widget/address_cart_widget.dart';

class ListAddressWidget extends StatelessWidget {
  final UserProvider userProvider;

  const ListAddressWidget({super.key, required this.userProvider});

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
            onTap: () {
              // Navigator.pushNamed(
              //   _,
              //   Routes.restaurantDetailScreen,
              //   arguments: restaurants[index],
              // ).then((value) => userProvider.refreshFavoritesData);
            },
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
