import 'package:food_app/data/model/data_repository.dart';
import 'package:food_app/features/login/ui/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInManager {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  Future<void> signIn() async {
    try {
      _user = await _googleSignIn.signIn();
    } catch (error) {
      // Xử lý lỗi nếu cần
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      _user = null;
    } catch (error) {
      // Xử lý lỗi nếu cần
    }
  }
   void UpdateProfileUser() async{
    if( await isSignedIn==true) {
      UserSingleton userSingleton = UserSingleton.getInstance();
      userSingleton.setName(_user!.displayName.toString());
      userSingleton.setEmail(_user!.email);
      userSingleton.setImage(_user!.photoUrl.toString());
    }
  }
  bool get isSignedIn => _user != null;
}
