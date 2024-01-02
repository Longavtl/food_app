import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/model/User.dart';
import 'package:food_app/data/model/data_repository.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/features/cart/ui/cart_screen.dart';
import 'package:food_app/features/chitiet_food/bloc/chitiet_bloc.dart';
import 'package:food_app/features/chitiet_food/bloc/chitiet_event.dart';
import 'package:food_app/features/chitiet_food/bloc/chitiet_state.dart';
import 'package:intl/intl.dart';
import '../../../data/model/new_food.dart';

class ChiTietScreen extends StatefulWidget {
  ChiTietScreen({required this.food,this.user});
  final User ?user;
  final NewFood  food;

  @override
  State<ChiTietScreen> createState() => _ChiTietScreenState();
}

class _ChiTietScreenState extends State<ChiTietScreen> {
  int quantity = 0;

  int thanhtien=0;

  @override
  Widget build(BuildContext context) {
    void decrementQuantity() {
      setState(() {
        if (quantity > 1) {
          quantity--;
        }
        thanhtien=quantity*widget.food.gia.toInt();
      });
    }
    void incrementQuantity() {
      setState(() {
        if(quantity <10)
        {quantity++;
        thanhtien=quantity*widget.food.gia.toInt();}
      });
    }
    void _showNumberInputDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          int newQuantity = quantity; // Khởi tạo giá trị mới từ giá trị hiện tại

          return AlertDialog(
            title: Text("Nhập số lượng"),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (newValue) {
                // Cập nhật giá trị mới khi người dùng nhập
                newQuantity = int.tryParse(newValue) ?? newQuantity;
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Hủy"),
              ),
              TextButton(
                onPressed: () {
                  // Xử lý khi người dùng nhấn Đồng ý
                  setState(() {
                    quantity = newQuantity;
                  });
                  Navigator.of(context).pop();
                },
                child: Text("Đồng ý"),
              ),
            ],
          );
        },
      );
    }
    {
      try {
        DateTime currentTime = DateTime.now();
        // Lấy tham chiếu tới collection "users" trong Firestore
        CollectionReference usersRef = FirebaseFirestore.instance.collection('oders');
        UserSingleton userSingleton = UserSingleton.getInstance();
        var formatter = DateFormat('dd/MM/yyyy');
        // Thêm hoặc cập nhật bản ghi với ID tương ứng
        usersRef.doc(widget.food.tenMon).set({
          'user':userSingleton.user.name,
          'tensp':widget.food.tenMon,
          'gia':widget.food.gia,
          'soluong':quantity,
          'url':widget.food.url,
          'time':formatter.format(currentTime),
        });
        print('Thêm vào giỏ thành công');
      } catch (e) {
        print('Lỗi khi thêm : $e');
      }
    }
    final ChiTietBloc chitietBloc= ChiTietBloc();
    return BlocConsumer<ChiTietBloc,ChiTietState>(
      bloc: chitietBloc,
      builder: (context, state) {
        switch(state.runtimeType){
          case ChiTietInitialState:
            return Scaffold(
                appBar: AppBar(title: Text('Chi tiết món'),),
                body:Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: double.infinity, // Chiều rộng của widget cha
                        child: FractionallySizedBox(
                          widthFactor: 1.0, // Tỷ lệ chiều rộng của hình ảnh so với widget cha (1.0 = 100%)
                          child: Image.network(
                            widget.food.url,
                            fit: BoxFit.fitWidth, // Giãn hình ảnh để chiếm hết chiều rộng
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,children: [
                          SizedBox(height: 10,),
                          Row(children: [
                            SizedBox(width: 15,),
                            ElevatedButton(onPressed: (){
                            }, style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                Size(30,20), // Chiều rộng và chiều cao của button
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.deepOrangeAccent, // Màu nền của button
                              ),
                            ),child: Text('Yêu thích',style: TextStyle(fontSize: 10),))
                            ,SizedBox(width: 20,),
                            Text(widget.food.tenMon,style: TextStyle(fontSize: 25),)
                          ],),
                          Padding(padding:EdgeInsets.only(left: 10) ,child: Text('Đánh giá: '+widget.food.sao.toString(),style: TextStyle(fontSize: 15,),)),
                          Center(child: Text('Mô tả sản phẩm',style: TextStyle(fontSize: 20,),))
                          ,SizedBox(height: 5,),
                          Padding(padding:EdgeInsets.only(left: 10)
                              , child: Text(widget.food.moTa,style: TextStyle(fontSize:17,fontFamily: 'Times New Roman')))
                          ,SizedBox(height: 10,),
                          Container(
                            height: 100,
                            width: double.infinity,
                            child: Row(children: [Container(width: 100 ,height:100,child: Image.network(widget.food.url)),
                              SizedBox(width: 10,),Container(child: Column(children: [
                                SizedBox(height: 20,),Text(widget.food.tenMon,style: TextStyle(fontSize: 11),),
                                SizedBox(height: 5,),
                                Text('Lượt bán',style: TextStyle(fontSize: 11)),
                                SizedBox(height: 5,),
                                Row(children: [Image.asset('images/cart.png', height: 18,width: 18,),SizedBox(width: 5,)
                                  ,Text('630',style: TextStyle(fontSize: 11))
                                ])],)),
                              Container(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width-334)),
                              IconButton(
                                icon: Icon(Icons.remove), onPressed:  decrementQuantity,
                                // onPressed: decrementQuantity,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showNumberInputDialog(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    quantity.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  incrementQuantity();
                                  chitietBloc.add(IncreaseEvent());
                                  print(chitietBloc.count);
                                },
                              )
                            ],),
                          )
                        ],
                        ),
                      ),
                    ),
                    Row(
                      children: [SizedBox(width: 10,),
                        Expanded(
                          child: ListTile(
                            title: Text('Tổng thành tiền'),
                            subtitle: Text('$thanhtien.000 VND'),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            chitietBloc.emit(ChiTietToCartState());
                          },
                          child: Text('Thêm vào giỏ'),
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                  ],
                )
            );
          default:
            return Container();
        }
      },
      listener:(context, state) {
        switch(state.runtimeType){
          case ChiTietToCartState:
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
          }
      },
    );

  }
}
