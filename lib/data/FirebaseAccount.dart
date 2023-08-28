import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:food_app/data/model/User.dart';

class FirebaseAccount{
  final User user;
  FirebaseAccount(this.user);
  static void CreateAccount(String name ,String pass,String email){
    DatabaseReference ref = FirebaseDatabase.instance.ref("users");
    ref.child(name.toString()).update({
      "textname": name,
      "textpass": pass,
      "textemail":email,
    });
}
  static Future<bool> CheckAccount(String name,String pass,String email) async {
    Completer<bool> completer = Completer<bool>();
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    bool accountExists = false;
    String nodePath = 'users/'+name.toString(); // Đường dẫn đến nút cần kiểm tra
    reference.child(nodePath).onValue.listen((event) {
      if (!accountExists) {
      if (event.snapshot.value != null) {
        completer.complete(false);
        // Dữ liệu đã tồn tại
      } else {
        CreateAccount(name, pass, email);
        return completer.complete(true);
        // SnackBarCustom.showSnackbar(context, 'Tạo tài khoản thành công!');
      }
    }});
    return completer.future;
  }
   static Future<bool> CheckLogin(String name, String pass) async {
    Completer<bool> completer = Completer<bool>();

    DatabaseReference reference = FirebaseDatabase.instance.reference();
    String nodePath = 'users/' + name.toString();

    reference.child(nodePath).onValue.listen((event) {
      if (event.snapshot.value != null) {
        // Dữ liệu đã tồn tại
        Map<String, dynamic> data = (event.snapshot.value as Map<Object?, Object?>).cast<String, dynamic>();
        User user = User(
          name: data['textname'],
          pass: data['textpass'],
          email: data['textemail'],
        );
        if (user.name == name && user.pass == pass) {
          print('Đăng nhập thành công'+ user.name+user.pass+name);
          completer.complete(true); // Trả về true khi đăng nhập thành công
        } else {
          completer.complete(false); // Trả về false khi tài khoản hoặc mật khẩu không đúng
        }
      } else {
        completer.complete(false); // Trả về false nếu không tìm thấy dữ liệu tài khoản
      }
    });
    return completer.future;
  }
  static void CheckExist(String name )
  {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    String nodePath = 'users/' + name.toString();
    reference.child(nodePath).onValue.listen((event){
      if (event.snapshot.value == null)
        {

        }
    });
  }
  static void UpdatePassword(String name, String newPass) {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users");
    ref.child(name).update({
      "textpass": newPass,
    });
  }
}