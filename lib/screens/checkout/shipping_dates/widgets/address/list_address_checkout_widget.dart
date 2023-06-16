import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/provider/products_provider.dart';
import 'package:quick_order/provider/user_provider.dart';
import 'package:quick_order/screens/checkout/shipping_dates/widgets/address/address_checkout_card_widget.dart';
import 'package:quick_order/screens/profile/addresses/widget/address_cart_widget.dart';

class ListAddressCheckoutWidget extends StatefulWidget {
  ListAddressCheckoutWidget({
    Key? key,
    required this.userProvider,
    required this.selectedAddressIndex,
    required this.onAddressSelected, // Agrega esta línea
  }) : super(key: key);

  final UserProvider userProvider;
  int selectedAddressIndex;
  final Function(int) onAddressSelected; // Agrega esta línea

  @override
  _ListAddressCheckoutWidgetState createState() =>
      _ListAddressCheckoutWidgetState();
}

class _ListAddressCheckoutWidgetState extends State<ListAddressCheckoutWidget> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 100),
      child: ListView.builder(
        itemCount: widget.userProvider.user!.addresses.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              setState(() {
                widget.selectedAddressIndex = index;
              });
              widget.onAddressSelected(index);
            },
            child: AddressCheckoutCardWidget(
              id: widget.userProvider.user!.addresses[index].id,
              name: widget.userProvider.user!.addresses[index].name,
              city: widget.userProvider.user!.addresses[index].city,
              number: widget.userProvider.user!.addresses[index].number,
              cp: widget.userProvider.user!.addresses[index].cp,
              address: widget.userProvider.user!.addresses[index].address,
              addressName:
              widget.userProvider.user!.addresses[index].addressName,
              isSelected: index == widget.selectedAddressIndex,
            ),
          );
        },
      ),
    );
  }
}
