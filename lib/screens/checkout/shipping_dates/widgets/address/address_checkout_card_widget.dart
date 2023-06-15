import 'package:flutter/material.dart';

class AddressCheckoutCardWidget extends StatefulWidget {
  final int id;
  final int number;
  final String name;
  final String city;
  final int cp;
  final String address;
  final String addressName;
  final bool isSelected;

  const AddressCheckoutCardWidget(
      {super.key,
      required this.id,
      required this.name,
      required this.city,
      required this.number,
      required this.cp,
      required this.address,
      required this.addressName,
      required this.isSelected});

  @override
  State<AddressCheckoutCardWidget> createState() =>
      _AddressCheckoutCardWidgetState();
}
class _AddressCheckoutCardWidgetState extends State<AddressCheckoutCardWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(
            color: widget.isSelected ? Colors.orange : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.addressName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5.0),
              Text(
                widget.address,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                widget.city,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                widget.name,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
