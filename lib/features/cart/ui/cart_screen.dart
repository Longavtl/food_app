import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/model/Oder.dart';
import 'package:food_app/data/model/data_repository.dart';
import 'package:food_app/features/cart/bloc/cart_bloc.dart';
import 'package:food_app/features/oder/ui/oder_screen.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    context.read<CartCubit>().initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, List<Oder>>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Cart'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    Oder item = state[index];
                    return ListTile(
                      leading: Container(
                        width: 140,
                        child: Row(
                          children: [
                            Checkbox(
                              key: UniqueKey(),
                              value: item.check,
                              onChanged: (bool? value) {
                                context.read<CartCubit>().toggleItemSelection(item, value);
                              },
                            ),
                            Image.network(
                              item.url,
                              height: 50,
                            ),
                          ],
                        ),
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
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(2, 10, 2, 2),
            child: ElevatedButton(
              onPressed: () {
                context.read<CartCubit>().oders_true(fromButton: true);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OderScreen()),
                );
              },
              child: Text(
                  'Đặt hàng - ${context.read<CartCubit>().thanhtien} .000 đ'),
            ),
          ),
        );
      }
    );
  }
}