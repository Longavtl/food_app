import 'package:flutter/material.dart';
import 'package:food_app/data/model/User.dart';
import '../../data/model/data_repository.dart';
import 'ChangePass.dart';

class Protifile extends StatelessWidget {
  Protifile();
  UserSingleton user = UserSingleton.getInstance();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Profile',style: TextStyle(color: Colors.black,),),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(alignment: Alignment.bottomCenter, children:[
              Container(height: 200,color: Color.fromRGBO(
                  49, 114, 232, 0.9019607843137255)),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 20,
                child: Container(color: Color.fromRGBO(145, 145, 145,0.5)),
              ),
              Positioned(
                top: 50,
                child: ClipOval(
                  child: Image.network(
                    user.user.pass.startsWith('http') ? user.user.pass : 'https://firebasestorage.googleapis.com/v0/b/fir-235c2.appspot.com/o/user.png?alt=media&token=a9796ec1-e1a8-4861-9e80-7e2e4fa0af0f',
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
            ]),
            SizedBox(height: 20,),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tên người dùng:', style: TextStyle(fontSize: 17,fontFamily: 'Times New Roman')),
                      SizedBox(height: 15),
                      Container(
                        height: 0.5,
                        color: Colors.black,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      Text('Địa chỉ email:', style: TextStyle(fontSize: 17,fontFamily: 'Times New Roman')),
                      SizedBox(height: 15),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.user.name, style: TextStyle(fontSize: 17,fontFamily: 'Times New Roman')),
                      SizedBox(height: 15),
                      Text(user.user.email, style: TextStyle(fontSize: 17,fontFamily: 'Times New Roman')),
                      SizedBox(height: 15),
                    ],
                  ),
                ],
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Tài khoản mạng xã hội',style: TextStyle(fontSize: 17,fontFamily: 'Times New Roman')),
                    Text('>',style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue))
                  ]),
            ),
            SizedBox(height: 15),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white),),
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.grey,
                      shape:const RoundedRectangleBorder(borderRadius:  BorderRadius.vertical(top:Radius.circular(20))),
                      isScrollControlled:true,
                      context: context,
                      builder: (BuildContext context)
                      {
                        return  modal_bottom();
                      });
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
                      'Đổi mật khẩu',
                      style: TextStyle(fontSize: 16,color: Colors.black),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
