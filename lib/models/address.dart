class Address {
  int id;
  int number;
  String name;
  String city;
  int cp;
  String address;
  String addressName;

  Address(
      {required this.name,
      required this.id,
      required this.city,
      required this.cp,
      required this.number,
      required this.address,
      required this.addressName});

  factory Address.fromJson(Map<String, dynamic> map) {
    return Address(
        id: map['id'],
        name: map['name'],
        city: map['city'],
        cp: map['cp'],
        number: map['number'],
        address: map['address'],
        addressName: map['addressName']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'name': name,
      'city': city,
      'cp': cp,
      'address': address,
    };
  }
}
