class Product {
  int id;
  String name;
  String photo;
  String description;
  double price;

  Product({
    required this.photo,
    required this.id,
    required this.description,
    required this.name,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> map) {

    return Product(
      id: map['id'],
      name: map['name'],
      photo: map['photo'],
      description: map['description'],
      price: map['price']
    );
  }
}
