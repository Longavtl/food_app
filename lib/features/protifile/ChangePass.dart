

import 'package:flutter/material.dart';
import 'package:food_app/data/FirebaseAccount.dart';
import 'package:food_app/data/model/User.dart';

import '../../data/model/data_repository.dart';

class modal_bottom extends StatelessWidget {
  UserSingleton user = UserSingleton.getInstance();
  modal_bottom({this.value_input = ''});

  TextEditingController _oldpass = TextEditingController();
  TextEditingController _newpass1 = TextEditingController();
  TextEditingController _newpass2 = TextEditingController();
  String value_input = '';

  void handleOnclick(BuildContext context) {
    final name = value_input;
    if (name.isEmpty) {
      return;
    }
    else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.viewInsetsOf(context),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(children: [
          Center(child: Text('Đổi mật khẩu',
              style: TextStyle(fontSize: 20, fontFamily: 'Times New Roman')),),
          SizedBox(height: 10,),
          TextField(
            controller: _oldpass,
            onChanged: (value) {
              value_input = value;
            },
            decoration: const InputDecoration(border: OutlineInputBorder()
                , labelText: 'Nhập  mật khẩu hiện tại'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: _newpass1,
            onChanged: (value) {
              value_input = value;
            },
            decoration: const InputDecoration(border: OutlineInputBorder()
                , labelText: 'Nhập mật khẩu mới'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: _newpass2,
            onChanged: (value) {
              value_input = value;
            },
            decoration: const InputDecoration(border: OutlineInputBorder()
                , labelText: 'Nhập lại mật khẩu'),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(onPressed: () {
                if (_newpass1.text == _newpass2.text) {
                FirebaseAccount.UpdatePassword(user.user.name, _newpass1.text);
                }
                else {
                  final snackBar = SnackBar(
                      content: Text('Hai mật khẩu mới không giống nhau!'));
                  ScaffoldMessenger.of(context).showSnackBar(
                      snackBar);
                }
              }
                  , child: const Text('Hoàn tất')))
        ],),
      ),
    );
  }

}