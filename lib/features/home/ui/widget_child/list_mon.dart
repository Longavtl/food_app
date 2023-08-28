import 'package:flutter/material.dart';
import 'package:food_app/data/model/firebase_newfood.dart';
import 'package:food_app/data/model/new_food.dart';
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
    return GridView.builder(
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
                Image.network(
                  food.url,
                  height: 140,
                  width: 160,
                ),
                Text(food.tenMon),
                Text(food.gia.toInt().toString()+".000 đ"),
                Text("Đánh giá :"+food.sao.toString()+" sao")
              ],
            ),
          ),
        );
      },
    );
  }
}
