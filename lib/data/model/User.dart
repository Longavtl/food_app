class User {
  String name;
  String pass;
  String email;
  User( {required this.name, required this.pass, required this.email});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['textname'],
      pass: json['textpass'],
      email: json['textemail'],
    );
  }


}