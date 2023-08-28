import 'package:food_app/data/model/User.dart';

class UserSingleton {
  static UserSingleton? _instance; // Declare as nullable
  User user; // User object
  UserSingleton._internal(this.user);
  static UserSingleton getInstance() {
    if (_instance == null) {
      _instance = UserSingleton._internal(User(name: 'long',pass: 'long',email: 'longavtl@gmail.com'));
    }
    return _instance!;
  }
}
