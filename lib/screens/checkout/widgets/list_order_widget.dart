import 'package:flutter/material.dart';
import 'package:quick_order/provider/products_provider.dart';
import 'package:quick_order/routes/routes.dart';
import 'package:quick_order/screens/checkout/widgets/modify_qty_widget.dart';
import '../../home/search_screen.dart';
import 'order_line_cart_widget.dart';

class ListOrderWidget extends StatelessWidget {
  const ListOrderWidget({Key? key, required this.provider}) : super(key: key);
  final ProductsProvider provider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size.height - 60),
      child: Column(
        children: [
          if (provider.order.lines.isEmpty)
            const NotFoundDataWidget(
              message: "No items in your order",
            ),
          if (provider.order.lines.isNotEmpty)
            Column(
              children: [
                SizedBox(
                  height: size.height - 200,
                    child: ListView.builder(
                      itemCount: provider.order.lines.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return ModifyQty(
                                    provider: provider, index: index);
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(25),
                          child: OrderLineCardWidget(
                            orderLine: provider.order.lines[index],
                          ),
                        );
                      },
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.shippindDates,
                        arguments: provider);
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
                  child: Container(
                    width: size.width, // Ancho completo de la pantalla
                    child: const Text(
                      "Pay",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
