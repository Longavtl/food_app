import 'package:food_app/data/model/User.dart';

class UserSingleton {
  static UserSingleton? _instance; // Declare as nullable
  User user; // User object

  UserSingleton._internal(this.user);

  static UserSingleton getInstance() {
    if (_instance == null) {
      _instance = UserSingleton._internal(User(name: 'long', pass: 'long', email: 'longavtl@gmail.com'));
    }
    return _instance!;
  }
  void setName(String name) {
    user.name = name;
  }

  void setPass(String pass) {
    user.pass = pass;
  }

  void setEmail(String email) {
    user.email = email;
  }
}
