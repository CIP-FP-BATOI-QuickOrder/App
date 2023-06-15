import 'package:flutter/material.dart';

class PaymentCheckoutCardWidget extends StatefulWidget {
  final int id;
  final String creditCart;
  final String expirationDate;
  final String bank;
  final String name;
  final bool isSelected;

  const PaymentCheckoutCardWidget(
      {super.key,
      required this.id,
      required this.name,
      required this.expirationDate,
      required this.bank,
      required this.creditCart,
      required this.isSelected});

  @override
  State<PaymentCheckoutCardWidget> createState() =>
      _PaymentCheckoutCardWidgetState();
}

class _PaymentCheckoutCardWidgetState extends State<PaymentCheckoutCardWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
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
                      widget.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.creditCart,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.bank,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

