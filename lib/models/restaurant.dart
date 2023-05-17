class Restaurant {
   int id;
   String name;
   String nif;
   String password;
   String photo;
   String city;
   String direction;

   Restaurant({required this.id, required this.name, required this.nif, required this.password, required this.photo, required this.city, required this.direction });

   factory Restaurant.fromJson(Map<String,dynamic> map){
     return Restaurant(id: map['id'], name: map['name'], nif: map['nif'], city: map['city'], direction: map['direction'], password: map['password'], photo: map['photo']);
   }

}