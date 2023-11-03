import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/model/Oder.dart';
import 'package:food_app/data/model/data_repository.dart';
import 'package:food_app/features/cart/bloc/cart_bloc.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<CartCubit>().initializeData(); // Khởi tạo dữ liệu ban đầu
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, List<Oder>>(
        builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text('Cart'),
            ),
            body: ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                Oder item = state[index];
                return ListTile(
                  leading: Image.network(
                    item.url,
                    height: 50,
                  ),
                  title: Text(item.tensp),
                  subtitle: Text(item.gia.toString() + '.000 đ'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(item.soluong.toString()),
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            context.read<CartCubit>().removeItem(item);
                          }),
                    ],
                  ),
                );
              },
            ),
            bottomNavigationBar: Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(2, 10, 2, 2),
              child: ElevatedButton(
                onPressed: () {
                  final snackBar =
                      SnackBar(content: Text('Đơn hàng đã lưu trên CSDL'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text(
                    'Thanh toán - ${context.read<CartCubit>().thanhtien} .000 đ'),
              ),
            )));
  }
}
