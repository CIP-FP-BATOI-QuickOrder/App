import 'package:flutter/material.dart';
import 'package:quick_order/provider/products_provider.dart';
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
            Expanded(
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
                          return ModifyQty(provider: provider, index: index);
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
        ],
      ),
    );
  }
}
