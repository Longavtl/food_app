import 'package:food_app/data/model/donhangmodel.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Donhang {
  final Donhangmodel donhangmodel;

  Donhang(this.donhangmodel);

  static Future<List<Donhangmodel>> layDonhangtheoten(String idtk) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('donhangs')
          .where('idtk', isEqualTo: idtk)
          .get();

      List<Donhangmodel> danhSachDonHang = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Donhangmodel(
          id: doc.id,
          idtk: data['idtk'],
          diachi: data['diachi'],
          tennguoinhan: data['tennguoinhan'],
          sdt: data['sdt'],
          trangthai: Trangthai.values.firstWhere(
                (element) => element.toString() == data['trangthai'],
          ),
        );
      }).toList();

      return danhSachDonHang;
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
      return []; // Trả về danh sách rỗng trong trường hợp lỗi
    }
  }


  static void taoDonHang(Donhangmodel donhangmodel,String orderId) async {
    try {
      await FirebaseFirestore.instance.collection('donhangs').doc(orderId).set({
        'idtk': donhangmodel.idtk,
        'diachi': donhangmodel.diachi,
        'tennguoinhan': donhangmodel.tennguoinhan,
        'sdt': donhangmodel.sdt,
        'trangthai': donhangmodel.trangthai.toString(),
      });
      print('object1');
    } catch (e) {
      print('Lỗi khi tạo đơn hàng: $e');
    }
  }

  static void capNhatDonHang(String idDonHang, Donhangmodel donhangCapNhat) async {
    try {
      await FirebaseFirestore.instance.collection('donhangs').doc(idDonHang).update({
        'idtk': donhangCapNhat.idtk,
        'diachi': donhangCapNhat.diachi,
        'tennguoinhan': donhangCapNhat.tennguoinhan,
        'sdt': donhangCapNhat.sdt,
        'trangthai': donhangCapNhat.trangthai.toString(),
      });
    } catch (e) {
      print('Lỗi khi cập nhật đơn hàng: $e');
    }
  }

  static void xoaDonHang(String idDonHang) async {
    try {
      await FirebaseFirestore.instance.collection('donhangs').doc(idDonHang).delete();
    } catch (e) {
      print('Lỗi khi xóa đơn hàng: $e');
    }
  }

  static Future<List<Donhangmodel>> layDanhSachDonHang() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('donhangs').get();

      List<Donhangmodel> danhSachDonHang = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Donhangmodel(
          id: doc.id,
          idtk: data['idtk'],
          diachi: data['diachi'],
          tennguoinhan: data['tennguoinhan'],
          sdt: data['sdt'],
          trangthai: Trangthai.values.firstWhere(
                (element) => element.toString() == data['trangthai'],
          ),
        );
      }).toList();
      return danhSachDonHang;
    } catch (e) {
      print('Lỗi khi lấy danh sách đơn hàng: $e');
      return [];
    }
  }
}
