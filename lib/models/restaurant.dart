class Restaurant {
  int id;
  String name;
  String nif;
  String password;
  String photo;
  String city;
  String direction;
  int deliveryTime;
  int deliveryPrice;
  double rating;
  List<String> tags;

  Restaurant(
      {required this.id,
      required this.name,
      required this.nif,
      required this.password,
      required this.photo,
      required this.city,
      required this.direction,
      required this.deliveryPrice,
      required this.deliveryTime,
      required this.rating,
      required this.tags});

  factory Restaurant.fromJson(Map<String, dynamic> map) {
    var tagsList = <String>[];
    if (map['tags'] != null && map['tags'] is List) {
      var tags = map['tags'] as List;
      tags.forEach((tag) {
        if (tag['name'] != null) {
          tagsList.add(tag['name']);
        }
      });
    }

    return Restaurant(
      id: map['id'],
      name: map['name'],
      nif: map['nif'],
      city: map['city'],
      direction: map['direction'],
      password: map['password'],
      photo: map['photo'],
      deliveryPrice: map['deliveryPrice'],
      deliveryTime: map['deliveryTime'],
      rating: map['rating'],
      tags: tagsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nif': nif,
      'password': password,
      'photo': photo,
      'city': city,
      'direction': direction,
      'deliveryTime': deliveryTime,
      'deliveryPrice': deliveryPrice,
      'rating': rating,
    };
  }
}
