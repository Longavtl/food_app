import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:food_app/data/model/data_repository.dart';

class FacebookAuthHelper {
  AccessToken? _accessToken;
  Map<String, dynamic>? _user;

  // Hàm đăng nhập Facebook
  Future<void> login() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      // Lấy thông tin người dùng sau khi đăng nhập thành công
      final userData = await FacebookAuth.instance.getUserData();
      _user = userData;
      print(_user);
    } else {
      // Đăng nhập thất bại
      print(result.status);
      print(result.message);
    }
  }

  // Hàm đăng xuất Facebook
  Future<void> logout() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _user = null;
  }

  // Kiểm tra xem người dùng đã đăng nhập hay chưa
  bool isLogged() {
    return _accessToken != null;
  }

  // Cập nhật thông tin người dùng sau khi đăng nhập
  void updateProfileUser() {
    if (isLogged()) {
      final name = _user?['name'];
      final email = _user?['email'];
      final image = _user?['picture']['data']['url'];
      UserSingleton userSingleton = UserSingleton.getInstance();
      if (name != null) {
        userSingleton.setName(name.toString());
      }
      if (email != null) {
        userSingleton.setEmail(email);
      }
      if (image != null) {
        userSingleton.setImage(image);
      }
    }
  }
  bool get isSignedIn => _user != null;
}