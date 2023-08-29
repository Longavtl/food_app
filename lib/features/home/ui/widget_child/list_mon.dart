import 'package:flutter/material.dart';
import 'package:food_app/data/model/firebase_newfood.dart';
import 'package:food_app/data/model/new_food.dart';
import 'package:food_app/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/home/bloc/home_state.dart';
class ListMonAn extends StatefulWidget {
  @override
  _ListMonAnState createState() => _ListMonAnState();
}

class _ListMonAnState extends State<ListMonAn> {
  final FirebaseNewFood newFood = FirebaseNewFood();
  List<NewFood> listfood = [];

  _ListMonAnState();
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async {
    await newFood.getMenuItems().then((menuItems) {
      setState(() {
        listfood=menuItems;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc=HomeBloc();
    return BlocConsumer<HomeBloc,HomeState>(
      listener: (context, state) {
        
      },
      builder:(context, state) =>
          GridView.builder(
          shrinkWrap: true,
          itemCount: listfood.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Số cột bạn muốn hiển thị
            childAspectRatio: 0.9, // Tỉ lệ giữa chiều rộng và chiều cao của mỗi item
          ),
          itemBuilder: (context, index) {
          NewFood food = listfood[index];
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ChiTietMon(food: food),
              //   ),
              // );
            },
            child: GridTile(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 120,
                    width: 160,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              food.url,)
                        )
                    ),
                  ),
                  Text(food.tenMon),
                  Text(food.gia.toInt().toString()+".000 đ"),
                  Text("Đánh giá :"+food.sao.toString()+" sao")
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
