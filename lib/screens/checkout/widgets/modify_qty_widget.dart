import 'package:flutter/material.dart';
import 'package:quick_order/models/order_line.dart';
import 'package:quick_order/screens/checkout/checkout_screen.dart';
import 'package:quick_order/screens/checkout/widgets/list_order_widget.dart';
import 'package:quick_order/screens/welcome/widgets/signing_button.dart';
import '../../../models/order.dart';
import '../../../models/product.dart';
import '../../../provider/products_provider.dart';
import '../../../routes/routes.dart';

class ModifyQty extends StatefulWidget {
  ProductsProvider provider;
  int index;

  ModifyQty({Key? key, required this.provider, required this.index})
      : super(key: key);

  @override
  _ModifyQtyState createState() => _ModifyQtyState();
}

class _ModifyQtyState extends State<ModifyQty> {
  int qty = 1;

  @override
  void initState() {
    qty = widget.provider.order.lines[widget.index].qty;
    super.initState();
  }

  void incrementQty() {
    setState(() {
      qty++;
    });
  }

  void decrementQty() {
    if (qty > 0) {
      setState(() {
        qty--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 14, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 6,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.orange,
            ),
          ),
          // Section 1 - increment button
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      widget.provider.order.lines[widget.index].product.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          decrementQty();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.orange,
                          shape: const CircleBorder(),
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.all(0),
                        ),
                        child: const Icon(Icons.remove,
                            size: 20, color: Colors.black),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          qty.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'poppins'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          incrementQty();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.orange,
                          shape: const CircleBorder(),
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.all(0),
                        ),
                        child: const Icon(Icons.add,
                            size: 20, color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async {
              bool confirmDelete = true;
              if (qty == 0) {
                confirmDelete = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const DeleteConfirmationDialog();
                  },
                );
              }
              if (confirmDelete) {
                OrderLine newLine = widget.provider.order.lines[widget.index];
                newLine.qty = qty;
                widget.provider.updateOrderLine(newLine);

                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushNamed(context, Routes.checkout,
                    arguments: widget.provider);
              }
            },
            style: ElevatedButton.styleFrom(
              side: const BorderSide(
                width: 1.0,
                color: Colors.orange,
              ),
              backgroundColor: Colors.orange,
              alignment: Alignment.center,
              shadowColor: Colors.black26,
              elevation: 5,
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 35,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: const Text(
              "Modify",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 5.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Are you sure you want to delete?',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'This action cannot be undone.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[300],
                    onPrimary: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
