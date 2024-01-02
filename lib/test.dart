import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_app/Components/FiconSVG.dart';
import 'package:food_app/Components/styles/color.dart';
import 'package:food_app/Components/styles/input_size.dart';
import 'package:food_app/Components/widgets/divider.dart';
import 'package:food_app/Components/widgets/filled_button.dart';
import 'package:food_app/Components/widgets/form.dart';
import 'package:food_app/Components/widgets/text_form_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/data/city.dart';
import 'package:http/http.dart' as http;

class TestScreen extends StatefulWidget {
   TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final emailController = TextEditingController();

  final pwdController = TextEditingController();

  final _formKey = GlobalKey<FFormState>();

  bool _hasInteracted = false;

  bool _isHidePwd = true;

  bool _isLogin=false;

  bool _hasData = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Địa chỉ',style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,),
      body: Column(
        children: [
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 15),
            width: MediaQuery.of(context).size.width,
            color: Colors.white12,
            child: Align(
                alignment: Alignment.centerLeft,child: Text('Liên hệ')),

          ),
          FForm(
            key: _formKey,
            autovalidateMode: _hasInteracted
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: FTextFormField(
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return FTextFieldStatus(
                            status: TFStatus.error, message: 'Hãy điền email của bạn!');
                      } else if (value.trim().length > 100) {
                        return FTextFieldStatus(
                            status: TFStatus.error,
                            message: 'Tài khoản không được quá 100 ký tự.');
                      } else {
                        return FTextFieldStatus(
                            status: TFStatus.normal, message: null);
                      }
                    },
                    size: FInputSize.size56.copyWith(height: 64),
                    labelText: 'Họ và tên',
                    controller: emailController,
                    onChanged: (value) {
                      print('Email field value changed: $value');
                      // Kiểm tra nếu email chứa từ "long" khi thay đổi giá trị
                      if(value.isNotEmpty)
                      {
                        setState(() {
                          _hasData=true;
                          if (value.toLowerCase().contains('long')) {
                            // _falseLogin();
                          }
                        });
                      }
                      else {

                        setState(() {
                          _hasData=false;
                        });
                      }

                    },
                    suffixIcon: _hasData==false?Container():FFilledButton.icon(
                      backgroundColor: FColors.transparent,
                      onPressed: () {
                        emailController.clear();
                      },
                      child: SvgPicture.string(SvgFIcon.suggestedc_remove,color: Colors.black45,),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: FTextFormField(
                    obscureText: _isHidePwd,
                    validator: (value) {
                      if (value.isEmpty) {
                        return FTextFieldStatus(
                            status: TFStatus.error, message: 'Hãy điền mật khẩu của bạn!');
                      } else if (value.length > 100) {
                        return FTextFieldStatus(
                            status: TFStatus.error,
                            message: 'Mật khẩu không được quá 100 ký tự.');
                      } else {
                        return FTextFieldStatus(
                            status: TFStatus.normal, message: null);
                      }
                    },
                    size: FInputSize.size56.copyWith(height: 64),
                    labelText: 'Số điện thoại',
                    controller: pwdController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: FTextFormField(
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return FTextFieldStatus(
                            status: TFStatus.error, message: 'Hãy điền email của bạn!');
                      } else if (value.trim().length > 100) {
                        return FTextFieldStatus(
                            status: TFStatus.error,
                            message: 'Tài khoản không được quá 100 ký tự.');
                      } else {
                        return FTextFieldStatus(
                            status: TFStatus.normal, message: null);
                      }
                    },
                    size: FInputSize.size56.copyWith(height: 64),
                    labelText: 'Họ và tên',
                    controller: emailController,
                    onChanged: (value) {
                      print('Email field value changed: $value');
                      // Kiểm tra nếu email chứa từ "long" khi thay đổi giá trị
                      if(value.isNotEmpty)
                      {
                        setState(() {
                          _hasData=true;
                          if (value.toLowerCase().contains('long')) {
                            // _falseLogin();
                          }
                        });
                      }
                      else {

                        setState(() {
                          _hasData=false;
                        });
                      }

                    },
                    suffixIcon: _hasData==false?Container():FFilledButton.icon(
                      backgroundColor: FColors.transparent,
                      onPressed: () {
                        emailController.clear();
                      },
                      child: SvgPicture.string(SvgFIcon.suggestedc_remove,color: Colors.black45,),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                FDivider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

