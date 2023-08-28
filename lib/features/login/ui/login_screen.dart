import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:food_app/data/FirebaseAccount.dart';
import 'package:food_app/data/model/User.dart';
import 'package:food_app/features/home/ui/home_screen.dart';
import 'package:food_app/features/login/bloc/login_bloc.dart';
import 'package:food_app/features/login/bloc/login_event.dart';
import 'package:food_app/features/login/bloc/login_state.dart';
import 'package:food_app/features/signup/ui/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginIn extends StatefulWidget {
  void Logout()
  {
    LoginInState()._googleSignIn.signOut().then((value) {
    }).catchError((e) {});
  }
  LoginIn({Key? key}) : super(key: key);
  @override
  State<LoginIn> createState() => LoginInState();
}
class LoginInState extends State<LoginIn> {
  late String name;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoggedIn = false;
  late GoogleSignInAccount _userObj;
  TextEditingController _textname = TextEditingController();
  TextEditingController _textpass = TextEditingController();

  User get user {
    return User(name: _userObj.displayName ?? '',
        email: _userObj.email,
        pass: _userObj.photoUrl.toString());
  }

  final LoginBloc homeBloc=LoginBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: homeBloc,
          listener: (context, state) {
            if (state is LoginSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Đăng nhập thành công')));
              Navigator.push(
                context, PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;
                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 1500), // Điều chỉnh thời gian chuyển đổi
              ),
              );
            } else if (state is LoginFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Đăng nhập ko thành công')));
                print('l1l');
            }
            else if(state is LoginToSignupState){
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => SignUp(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0); // Bắt đầu từ phải
                    const end = Offset.zero; // Kết thúc ở vị trí ban đầu
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 1500), // Điều chỉnh thời gian chuyển đổi
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
                resizeToAvoidBottomInset: false,
                body: Stack(
                    children: [Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [ Color.fromARGB(39, 33, 243, 43), Colors.blue],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 150,
                                child: Align(
                                    alignment: Alignment(0, 0.5),
                                    child: const Text('Đăng nhập',
                                      style: TextStyle(fontFamily: 'Time New Roman',
                                          fontSize: 30,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),)),
                              ),
                              Image.asset(
                                'images/lock.png',
                                width: 120,
                                height: 120,
                              ),
                              Container(
                                width: double.infinity,
                                height: 20,
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.9,
                                child: TextField(
                                  controller: _textname,
                                  decoration: InputDecoration(
                                      hintText: 'Enter your account ?',
                                      filled: true,
                                      fillColor: Colors.white
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 5,
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.9,
                                child: TextField(
                                  obscureText: true,
                                  controller: _textpass,
                                  decoration: InputDecoration(
                                      hintText: 'Enter your password ?',
                                      filled: true,
                                      fillColor: Colors.white
                                  ),
                                ),
                              ),
                              Container(height: 10,),
                              FractionallySizedBox(
                                widthFactor: 0.9,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if(_textname.text.isNotEmpty&&_textpass.text.isNotEmpty)
                                    {
                                      homeBloc.add(LoginButtonPressedEvent(username:_textname.text ,password:_textpass.text));
                                    }
                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tài khoản hoặc mật khẩu không để trống')));
                                    }
                                  },
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(horizontal: 16,
                                          vertical: 8), // Khoảng cách đệm
                                    ),
                                    minimumSize: MaterialStateProperty.all<Size>(
                                      Size(double.infinity,
                                          48), // Chiều rộng và chiều cao của button
                                    ),
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                      Colors.blue, // Màu nền của button
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8), // Đường viền cong của button
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Đăng nhập',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white, // Màu chữ của button
                                    ),
                                  ),
                                ),
                              ),
                              Container(height: 10,),
                              Center(child: const Text(
                                  'Hoặc đăng nhập bằng tài khoản khác ?'))
                              ,
                              Container(height: 10,),
                              FractionallySizedBox(
                                widthFactor: 0.7,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final snackBar = SnackBar(
                                        content: Text('Chức năng đang xây dựng!'));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        snackBar);
                                    LoginInState()._googleSignIn.signOut().then((value) {
                                      // setState(() {
                                      //   _isLoggedIn = false;
                                      // });
                                    }).catchError((e) {});
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.facebook,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Đăng nhập bằng Facebook',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              , Container(height: 3,)
                              , Text('Hoặc', style: TextStyle(fontSize: 13)),
                              Container(height: 3,)
                              , MaterialButton(
                                onPressed: () {
                                  _googleSignIn.signIn().then((userData) {
                                    setState(() {
                                      _isLoggedIn = true;
                                      _userObj = userData!;
                                    });
                                  }).catchError((e) {
                                    print(e);
                                  });
                                },
                                height: 40,
                                minWidth: 200,
                                color: Colors.red,
                                child: const Text('Google Sign In',
                                  style: TextStyle(color: Colors.white),),
                              )
                            ],

                          ),
                        ],
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
// Đặt bottom để widget con nằm ở dưới cùng
                        child: Container(
                          height: 50,
                          child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text('Bạn chưa có tài khoản. '),
                            GestureDetector(
                              onTap: () {
                                homeBloc.add(LoginToSignupEvent());
                              },
                              child: Text(
                                'Sign Up?',
                                style: TextStyle(
                                  fontFamily: 'Time New Roman',
                                  fontSize: 18,
                                  color: Colors.amber,
                                ),
                              ),
                            )
                          ],)),
                        ),
                      ),
                    ])
            );
          },
        );
  }
}
