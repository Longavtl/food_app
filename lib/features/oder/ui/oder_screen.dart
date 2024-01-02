import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/Components/styles/color.dart';
import 'package:food_app/Components/styles/input_size.dart';
import 'package:food_app/Components/widgets/filled_button.dart';
import 'package:food_app/Components/widgets/form.dart';
import 'package:food_app/Components/widgets/text_form_field.dart';
import 'package:food_app/data/chitietdonhang.dart';
import 'package:food_app/data/donhang.dart';
import 'package:food_app/data/model/Oder.dart';
import 'package:food_app/data/model/data_repository.dart';
import 'package:food_app/data/model/donhangmodel.dart';
import 'package:food_app/features/cart/bloc/cart_bloc.dart';
import 'package:food_app/features/home_page/home/ui/home_screen.dart';
import 'package:food_app/map.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';

import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
class OderScreen extends StatefulWidget {
  OderScreen({super.key});

  @override
  State<OderScreen> createState() => _OderScreenState();
}

class _OderScreenState extends State<OderScreen> {
  Donhangmodel ?_donhangmodel;
  final _dcController = TextEditingController();
  final _hvtController = TextEditingController();
  final _sdtController = TextEditingController();
  final _formKey = GlobalKey<FFormState>();
  UserSingleton userSingleton = UserSingleton.getInstance();
  bool _hasData = false;
  bool _hasInteracted = false;
  List<dynamic> cities = [];
  List<dynamic> districts = [];
  List<dynamic> wards = [];
  String dcnh='';
  String dc='';
  String sdt='';
  CartCubit? cartCubit;
  String buildSelectedChoicesText() {
    String city = selectedCity > 0 && selectedCity <= cities.length
        ? cities[selectedCity - 1]['name']
        : '';

    String district = selectedDistrict > 0 && selectedDistrict <= districts.length
        ? districts[selectedDistrict - 1]['name']
        : '';

    String ward = '';
    if (selectedWard != null &&
        selectedWard! > 0 &&
        selectedWard! <= wards.length) {
      ward = wards[selectedWard! - 1]['name'];
    }

    return 'Thành phố: $city, Quận: $district, Phường: $ward';
  }
  int selectedCity = 1;
  int selectedDistrict = 1;
  int ?selectedWard=1;  // Use nullable int for selectedWard

  @override
  void initState() {
    super.initState();
    cartCubit = BlocProvider.of<CartCubit>(context);
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://provinces.open-api.vn/api/?depth=3'));
    if (response.statusCode == 200) {
      setState(() {
        cities = json.decode(utf8.decode(response.bodyBytes));
        updateDistrictAndWard();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  void updateDistrictAndWard() {
    setState(() {
      districts = cities[selectedCity - 1]['districts'];
        wards = districts[selectedDistrict - 1]['wards'];//
    });
  }
  void _dathang(){
    FocusScope.of(context).unfocus();
    if (!_hasInteracted) {
      setState(() {
        _hasInteracted = true;
        // print('object');
      });
    }
    List<Oder> selectedItems = cartCubit!.getSelectedItems();
    // selectedItems.forEach((item) {
    //   print(item.toString());
    // });
    if (_dcController.text.isNotEmpty &&
        _hvtController.text.isNotEmpty &&
        _sdtController.text.isNotEmpty) {
      khoitaodonhang();
    }
  }
  void khoitaodonhang(){
    List<Oder> selectedItems = cartCubit!.getSelectedItems();
    selectedItems.forEach((item) {
      print(item.toString());
    });
    String generateOrderID() {
      var uuid = Uuid();
      return uuid.v1(); // Sử dụng uuid để sinh mã ngẫu nhiên dựa trên thời gian
    }
    String maDH=generateOrderID();
    _donhangmodel=Donhangmodel(id: "id", idtk: userSingleton.user.name,  diachi: DC.toString()+' '+dcNH.toString(), tennguoinhan: _hvtController.text, sdt: _sdtController.text, trangthai: Trangthai.Choxacnhan);
    Donhang.taoDonHang(_donhangmodel!,maDH);
    ChiTietDonHang.taoCTDonHang(selectedItems,maDH);
    _showOrderSuccessDialog(context);
  }
  Placemark place = Placemark();// Khai báo ở đầu lớp
  String tenNH='';
  String sdtNH='';
  String dcNH='';
  String DC='';
  bool light = false;
  void _showOrderSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Đặt hàng thành công"),
          content: Text("Cảm ơn bạn đã đặt hàng! Đơn hàng của bạn đã được xác nhận."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
                _navigateToHomeAfterDelay(); // Chuyển về màn hình Home sau vài giây
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToHomeAfterDelay() {
    const delayDuration = Duration(seconds: 2); // Thời gian trễ trước khi chuyển màn hình (2 giây trong ví dụ này)
    Timer(delayDuration, () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));// Chuyển về màn hình Home
    });
  }
  @override
  Widget build(BuildContext context) {
    void _mapSmple(BuildContext context) async {
      Map<String, dynamic>? result = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        clipBehavior: Clip.antiAlias,
        builder: (BuildContext context) {
          return MapSample();
        },
      );

      if (result != null && result.containsKey('place') && result.containsKey('isMap')) {
        Placemark _place = result['place'];
        bool isMap = result['isMap'];
        setState(() {
          place = _place;
          print(place);
          light=isMap;
          DC=' Đường:${place.street}';
          dcNH=' Thành phố: ${place.administrativeArea}, Quận: ${place.subAdministrativeArea},  ${place.name}';
        });
      }
    }
    double w=MediaQuery.of(context).size.width/414;
    double h=MediaQuery.of(context).size.height/896;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Order confirmation",style: TextStyle(
            fontWeight: FontWeight.w400,color: Colors.white
          ),),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              InkWell(
                onTap: (){_mapSmple(context);},
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black,strokeAlign: BorderSide.strokeAlignCenter,width: 0.5),borderRadius: BorderRadius.circular(10)),
                  width: w*414,
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  height: h*130,
                  child: Row(
                    children: [
                      Container(width: 40*w,
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(top: 10,left: 10),
                          child: Image.asset('images/location.png',height: 20,width: 20,)),
                      Container(
                        width: 340*w,
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Địa chỉ nhận hàng',style: TextStyle(fontSize: 15,fontWeight:FontWeight.w400 ),),
                            SizedBox(height: 3,),
                            Text('$tenNH | $sdtNH',style: TextStyle(fontSize: 15,fontWeight:FontWeight.w400 )),
                            SizedBox(height: 2,),
                            Text('$DC',style: TextStyle(fontSize: 15,fontWeight:FontWeight.w400 )),
                            SizedBox(height: 2,),
                            Text(dcNH!,style: TextStyle(fontSize: 13,fontWeight:FontWeight.w400 ))
                          ],
                        ),
                      ),
                      Container(
                        width: 14*w,
                        child: Icon(
                          Icons.chevron_right,size: 20,
                        ),
                      ),
                      SizedBox(width: 5,),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<int>(
                      value: selectedCity,
                      items: cities
                          .where((city) => city['code'] == 1) // Filter to only include Hanoi
                          .map<DropdownMenuItem<int>>((dynamic city) {
                        return DropdownMenuItem<int>(
                          value: city['code'],
                          child: Text(city['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCity = value!;
                          selectedDistrict = 1;
                          selectedWard = null;  // Reset selectedWard when city changes
                          updateDistrictAndWard();
                        });
                      },
                      isExpanded: true,
                      hint: Text('Chọn thành phố'),
                    ),
                    SizedBox(height: 16.0),
                    DropdownButton<int>(
                      value: selectedDistrict,
                      items: districts.map<DropdownMenuItem<int>>((dynamic district) {
                        return DropdownMenuItem<int>(
                          value: district['code'],
                          child: Text(district['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDistrict = value!;
                          selectedWard = null;  // Reset selectedWard when district changes
                          updateDistrictAndWard();
                        });
                      },
                      isExpanded: true,
                      hint: Text('Chọn quận'),
                    ),
                    DropdownButton<int>(
                      value: selectedWard,
                      items: wards.map<DropdownMenuItem<int>>((dynamic ward) {
                        return DropdownMenuItem<int>(
                          value: wards.indexOf(ward) + 1, // Sử dụng chỉ mục làm giá trị
                          child: Text(ward['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedWard = value;
                        });
                      },
                      isExpanded: true,
                      hint: Text('Chọn phường'),
                    ),
                  ],
                ),
              ),
              FForm(
                key: _formKey,
                autovalidateMode: _hasInteracted
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 15,),
                        Text('Đặt làm địa chỉ nhận hàng'),
                        Switch.adaptive(
                          // Don't use the ambient CupertinoThemeData to style this switch.
                          applyCupertinoTheme: false,
                          value: light,
                          onChanged: (bool value) {
                            setState(() {
                              light = value;
                              if(light==true){
                                DC=buildSelectedChoicesText();
                                dcNH=_dcController.text;
                                sdtNH=_sdtController.text;
                                tenNH=_hvtController.text;
                              }
                              else{
                                DC='';
                                dcNH='';
                                sdtNH='';
                                tenNH='';
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: FTextFormField(
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return FTextFieldStatus(
                                status: TFStatus.error, message: 'Hãy điền địa chỉ nhận của bạn!');
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
                        labelText: 'Nhập địa chỉ nhận hàng',
                        controller: _dcController,
                        onChanged: (value) {
                        },
                        suffixIcon: _hasData==false?Container():FFilledButton.icon(
                          backgroundColor: FColors.transparent,
                          onPressed: () {
                            _dcController.clear();
                          },
                          child:Icon(Icons.highlight_remove)
                        ),
                      ),
                    ),
                    SizedBox(height: 6,),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: FTextFormField(
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return FTextFieldStatus(
                                status: TFStatus.error, message: 'Hãy điền họ và tên của bạn!');
                          } else if (value.trim().length > 100) {
                            return FTextFieldStatus(
                                status: TFStatus.error,
                                message: 'Không được quá 100 ký tự.');
                          } else {
                            return FTextFieldStatus(
                                status: TFStatus.normal, message: null);
                          }
                        },
                        size: FInputSize.size56.copyWith(height: 64),
                        labelText: 'Người nhận',
                        controller: _hvtController,
                        onChanged: (value) {
                        },
                        suffixIcon: _hasData==false?Container():FFilledButton.icon(
                            backgroundColor: FColors.transparent,
                            onPressed: () {
                              _hvtController.clear();
                            },
                            child:Icon(Icons.highlight_remove)
                        ),
                      ),
                    ),
                    SizedBox(height: 6,),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: FTextFormField(
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return FTextFieldStatus(
                                status: TFStatus.error, message: 'Hãy điền số điện thoại của bạn!');
                          } else if (value.trim().length > 100) {
                            return FTextFieldStatus(
                                status: TFStatus.error,
                                message: 'Không được quá 100 ký tự.');
                          } else {
                            return FTextFieldStatus(
                                status: TFStatus.normal, message: null);
                          }
                        },
                        size: FInputSize.size56.copyWith(height: 64),
                        labelText: 'Số điện thoại người nhận',
                        controller: _sdtController,
                        onChanged: (value) {
                        },
                        suffixIcon: _hasData==false?Container():FFilledButton.icon(
                            backgroundColor: FColors.transparent,
                            onPressed: () {
                              _sdtController.clear();
                            },
                            child:Icon(Icons.highlight_remove)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16,),

            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 50,
          padding: EdgeInsets.fromLTRB(2, 10, 2, 2),
          child: ElevatedButton(
            onPressed: () {
             _dathang();
            },
            child: Text(
                'Xác nhận đặt hàng'),
          ),
        ),
    );
  }
}
