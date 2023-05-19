class Restaurant {
  int id;
  String name;
  String nif;
  String password;
  String photo;
  String city;
  String direction;
  int delivery_time;
  int delivery_price;

  Restaurant(
      {required this.id,
      required this.name,
      required this.nif,
      required this.password,
      required this.photo,
      required this.city,
      required this.direction,
      required this.delivery_price,
      required this.delivery_time});

  factory Restaurant.fromJson(Map<String, dynamic> map) {
    return Restaurant(
        id: map['id'],
        name: map['name'],
        nif: map['nif'],
        city: map['city'],
        direction: map['direction'],
        password: map['password'],
        photo: map['photo'],
        delivery_price: map['deliveryPrice'],
        delivery_time: map['deliveryTime']);
  }
}
