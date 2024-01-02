import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/model/Oder.dart';
import 'package:food_app/data/model/data_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CartCubit extends Cubit<List<Oder>> {
  List<Oder> oders = [];
  UserSingleton userSingleton = UserSingleton.getInstance();
  int thanhtien=0;
  List<Oder> getSelectedItems() {
    return oders.where((item) => item.check).toList();
  }
  CartCubit() : super([]);
  void initializeData() {
    // Khởi tạo dữ liệu ban đầu ở đây bằng cách đọc từ Firestore
    _initializeData();
  }
  void removeItem(Oder item) async{
    // Xóa mục khỏi danh sách oders
    oders.remove(item);
    updateThanhTien();
    // Emit trạng thái mới sau khi xóa
    try {
      await FirebaseFirestore.instance
          .collection('oders')
          .doc(item.tensp)
          .delete();
      print('Cubit: Xóa món ăn thành công');
    } catch (e) {
      print('Lỗi: $e');
    }
    emit([...oders]);
  }
  Future<void> _initializeData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('oders')
          .where('user', isEqualTo: userSingleton.user.name)
          .get();
      oders = querySnapshot.docs.map((doc) => Oder.fromDocumentSnapshot(doc)).toList();
      userSingleton.number = oders.length;
      emit([...oders]);
      // print(oders.length);// Cập nhật trạng thái ban đầu của Cubit
    } catch (e) {
      print('Lỗi khi đọc dữ liệu: $e');
    }
    updateThanhTien();
  }
  void updateThanhTien() {
    int total = 0;
    for (int i = 0; i < oders.length; i++) {
      if (oders[i].check==true) {
        total += oders[i].soluong * oders[i].gia;
      }
    }
    thanhtien = total;
    emit([...oders]);
  }
  void toggleItemSelection(Oder item, bool? value) {
    if (value != null) {
      if (value) {
       item.setCheck(value);
      } else {
        item.setCheck(value);
      }
      updateThanhTien();
      emit([...oders]);
      oders_true();
    }
  }
  void oders_true({bool fromButton = false}) {
    if (fromButton) {
      List<Oder> getSelectedItems() {
        return oders.where((item) => item.check).toList();
      }
      List<Oder> selectedItems = getSelectedItems();
      selectedItems.forEach((item) {
        print(item.toString());
      });
    }
  }
}