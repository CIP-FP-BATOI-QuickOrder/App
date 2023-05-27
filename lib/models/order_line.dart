class OrderLine {
  int id;
  int orderId;
  int productId;
  int qty;
  double price;
  double unitPrice;

  OrderLine(
      {required this.price,
      required this.qty,
      required this.id,
      required this.orderId,
      required this.productId,
      required this.unitPrice});
}
