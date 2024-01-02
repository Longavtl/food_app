import 'package:flutter/material.dart';
import 'package:food_app/data/model/firebase_newfood.dart';
import 'package:food_app/data/model/new_food.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/chitiet_food/ui/chitiet_screen.dart';
import 'package:food_app/features/home_page/home/bloc/home_bloc.dart';
import 'package:food_app/features/home_page/home/bloc/home_event.dart';
import 'package:food_app/features/home_page/home/bloc/home_state.dart';
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
    NewFood food;
    int i=1;
    return BlocConsumer<HomeBloc,HomeState>(
      bloc: homeBloc,
      listener:(context, state) {
        if(state is HomeToChiTietScreenState)
        {
          Navigator.push(context, MaterialPageRoute(builder:(context) => ChiTietScreen(food: listfood[i]),));
        }
      },
      builder:(context, state) =>
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            children: List.generate(listfood.length, (index) {
              food = listfood[index];
              return GestureDetector(
                onTap: () {
                  homeBloc.add(HomeToChiTietEvent(food));
                  i=index;
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black12,
                  ),
                  margin: EdgeInsets.all(10),
                  child: GridTile(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 110,
                          width: 160,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(food.url),
                            ),
                          ),
                        ),
                        Text(food.tenMon),
                        Text(food.gia.toInt().toString() + ".000 đ"),
                        Text("Đánh giá: " + food.sao.toString() + " sao")
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
    );
  }
}
