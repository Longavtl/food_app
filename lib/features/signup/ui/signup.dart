import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/home/ui/home_screen.dart';
import 'package:food_app/features/login/ui/login_screen.dart';
import 'package:food_app/features/signup/bloc/signup_bloc.dart';
import 'package:food_app/features/signup/bloc/signup_event.dart';
import 'package:food_app/features/signup/bloc/signup_state.dart';
import 'package:food_app/features/signup/ui/SnackBar.dart';
class SignUp extends StatelessWidget{
  TextEditingController _textname = TextEditingController();
  TextEditingController _textpass1 = TextEditingController();
  TextEditingController _textpass2 = TextEditingController();
  TextEditingController _textemail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final SignupBloc signupBloc=SignupBloc();
    return BlocConsumer<SignupBloc,SignupState>(
        bloc: signupBloc,
        listener: (context, state) {
          if(state is SignupToLoginSate)
            {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => LoginIn(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(-1.0, 0.0); // Bắt đầu từ phải
                    const end = Offset.zero; // Kết thúc ở vị trí ban đầu (trái)
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
          else if(state is SignupSuccessState)
            {
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
            }
        },
        builder: (context, state) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                  children: [Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [ Color.fromARGB(39, 33, 243, 43),Colors.blue],
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
                              height: 100,
                            ),
                            Container(
                              width: double.infinity,
                              height: 150,
                              child:Align(
                                  alignment: Alignment(0, 0.5),
                                  child: const Text('Đăng ký tài khoản',
                                    style: TextStyle(fontFamily: 'Time New Roman',fontSize: 30,color: Colors.blue,fontWeight: FontWeight.bold),)),
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
                              height: 10,
                            ),
                            FractionallySizedBox(
                              widthFactor: 0.9,
                              child: TextField(
                                controller: _textemail,
                                decoration: InputDecoration(
                                    hintText: 'Enter your email ?',
                                    filled: true,
                                    fillColor: Colors.white
                                ),
                              ),
                            ),
                            Container(height: 10,),
                            FractionallySizedBox(
                              widthFactor: 0.9,
                              child: TextField(
                                obscureText: true,
                                controller: _textpass1,
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
                              child: TextField(
                                obscureText: true,
                                controller: _textpass2,
                                decoration: InputDecoration(
                                    hintText: 'Confirm your password ?',
                                    filled: true,
                                    fillColor: Colors.white
                                ),
                              ),
                            ),
                            Container(height: 25,),
                            FractionallySizedBox(
                              widthFactor: 0.9,
                              child: ElevatedButton(
                                onPressed: () {
                                  if(_textname.text.isNotEmpty&&_textpass1.text.isNotEmpty&&_textpass2.text.isNotEmpty&&_textemail.text.isNotEmpty) {
                                    if(_textname.text.length>=6&&_textpass1.text.length>=6) {
                                      _textpass1.text == _textpass2.text
                                          ? signupBloc.add(SignupButtonPressedEvent(username: _textname.text, password:_textpass1.text,email: _textemail.text))
                                          : SnackBarCustom.showSnackbar(
                                          context, 'Hai mật khẩu không giống nhau');
                                    }
                                    else{
                                      SnackBarCustom.showSnackbar(context,'Tài khoản hoặc mật khẩu quá ngắn!');
                                    }
                                  }
                                  else{
                                    SnackBarCustom.showSnackbar(context,'Tài khoản hoặc mật khẩu không được để trống!');
                                  }
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Khoảng cách đệm
                                  ),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    Size(double.infinity, 48), // Chiều rộng và chiều cao của button
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.blue, // Màu nền của button
                                  ),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8), // Đường viền cong của button
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Đăng ký',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white, // Màu chữ của button
                                  ),
                                ),
                              ),
                            ),
                            Container( height: 10,),
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
                        child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                          Text('Bạn đã có tài khoản. '),
                          GestureDetector(
                            onTap: () {
                             signupBloc.add(SignupToLoginEvent());
                            },
                            child: Text(
                              'Sign In?',
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
        }
    );
  }
}
