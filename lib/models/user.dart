class User {
  int id;
  String name;
  String surname;
  String email;
  String password;
  String phone;
  int credit;
  String photo;

  User(
      {required this.id, required this.name, required this.surname, required this.email, required this.password, required this.phone, required this.credit, required this.photo});

  factory User.fromJson(Map<String, dynamic> map){
    return User(id: map['id'],
        name: map['name'],
        surname: map['surname'],
        email: map['email'],
        password: map['password'],
        phone: map['phone'],
        credit: map['credit'],
        photo: map['photo']);
  }

}