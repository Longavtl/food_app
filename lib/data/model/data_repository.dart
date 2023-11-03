import 'package:food_app/data/model/User.dart';

class UserSingleton {
  static UserSingleton? _instance; // Declare as nullable
  User user; // User object
  bool isLoginGoogle = false;
  UserSingleton._internal(this.user,this.urlImage);
  int number=0;
  String urlImage;
  static UserSingleton getInstance() {
    if (_instance == null) {
      _instance = UserSingleton._internal(User(name: 'long', pass: 'long', email: 'longavtl@gmail.com'),'https://firebasestorage.googleapis.com/v0/b/fir-235c2.appspot.com/o/user.png?alt=media&token=a9796ec1-e1a8-4861-9e80-7e2e4fa0af0f');
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
  void setLoginGoogle(bool isLoginGoogle ){
    isLoginGoogle=true;
  }
  void setImage(String url ){
    urlImage=url;
  }
}
