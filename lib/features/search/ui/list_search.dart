import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/data/model/firebase_newfood.dart';
import 'package:food_app/data/model/new_food.dart';
import 'package:food_app/features/chitiet_food/ui/chitiet_screen.dart';
class ListSearch  extends StatefulWidget {
  String search;
  ListSearch({required Key key, required this.search,}) : super(key: key);
  @override
  State<ListSearch> createState() => _ListSearchState(search);
}
class _ListSearchState extends State<ListSearch> {
  String search;
  _ListSearchState(this.search,);
  final FirebaseNewFood newFood = FirebaseNewFood();
  List<NewFood> listfood = [];
  void initState() {
    super.initState();
    readUsers(search);
  }
  @override
  void didUpdateWidget(ListSearch oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('list'+search);
    if (search != oldWidget.search) {
      // Kiểm tra nếu giá trị search thay đổi
      listfood.clear(); // Xóa danh sách cũ
      readUsers(search); // Đọc lại danh sách với giá trị search mới
    }
  }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: listfood.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // Số cột bạn muốn hiển thị
        childAspectRatio: 0.9, // Tỉ lệ giữa chiều rộng và chiều cao của mỗi item
      ),
      itemBuilder: (context, index) {
        NewFood food = listfood[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChiTietScreen(food: food,),
              ),
            );
          },
          child: GridTile(
            child: Center(
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
          ),
        );
      },
    );
  }
  Future<void> readUsers(String search) async
  {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('menu')
          .where('tenMon', isEqualTo: search)
          .get();
     if(querySnapshot.docs.isNotEmpty)
       { querySnapshot.docs.forEach((doc) {
         NewFood food = NewFood.fromDocumentSnapshot(doc);
         setState(() {
           listfood.add(food);
         });
       });}
     else{
       final snackBar = SnackBar(
           content: Text('Món ăn không tồn tại.Nhập vào tên món hợp lệ.VD: Bún thịt'));
       ScaffoldMessenger.of(context).showSnackBar(
           snackBar);
     }
    } catch (e) {
      print('Lỗi khi đọc dữ liệu: $e');
    }
  }
}
