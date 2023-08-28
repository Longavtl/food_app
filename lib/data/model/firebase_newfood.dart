import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/data/model/new_food.dart';
class FirebaseNewFood{
  final CollectionReference menuCollection =
  FirebaseFirestore.instance.collection('menu');
  Future<void> addMenuItem(
      String maMon, String tenMon, double gia, String moTa, double sao,String url) async {
    try {
      await menuCollection.doc(maMon).set({
        'tenMon': tenMon,
        'gia': gia,
        'moTa': moTa,
        'sao': sao,
        'url': url,
      });
      print('Thêm món ăn thành công');
    } catch (error) {
      print('Lỗi khi thêm món ăn: $error');
    }
  }
  Future<List<NewFood>> getMenuItems() async {
    try {
      final querySnapshot = await menuCollection.get();
      final menuItems = querySnapshot.docs
          .map((doc) => NewFood(
        maMon: doc.id,
        tenMon: doc['tenMon'],
        gia: doc['gia'] ,
        moTa: doc['moTa'],
        sao: doc['sao'],
        url: doc['url'],
      ))
          .toList();
      return menuItems;
    } catch (error) {
      print('Lỗi khi đọc danh sách món ăn: $error');
      return [];
    }
  }
}