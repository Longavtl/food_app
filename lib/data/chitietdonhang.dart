import 'package:food_app/data/donhang.dart';
import 'package:food_app/data/model/Oder.dart';
import 'package:food_app/data/model/donhangmodel.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChiTietDonHang {
  final List<Oder> donhangList;

  ChiTietDonHang(this.donhangList);

  static Future<void> taoCTDonHang(List<Oder> CTdonhangList, String orderId) async {
    for (var donhang in CTdonhangList) {
      // Tạo tài liệu chi tiết đơn hàng
      await FirebaseFirestore.instance.collection('ChitietDH').add({
        'orderId': orderId,
        'tenSP': donhang.tensp,
        'gia': donhang.gia,
        'soluong': donhang.soluong,
        'url':donhang.url,
      });
    }
  }

  static void capNhatDonHang(String idDonHang, Donhangmodel donhangCapNhat) async {
    try {
      await FirebaseFirestore.instance.collection('donhangs').doc(idDonHang).update({
        // 'maSp': donhangCapNhat.maSp,
        'idtk': donhangCapNhat.idtk,
        // 'tenSP': donhangCapNhat.tenSP,
        // 'gia': donhangCapNhat.gia,
        // 'soluong': donhangCapNhat.soluong,
        // 'thanhtien': donhangCapNhat.thanhtien,
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
          // maSp: data['maSp'],
          idtk: data['idtk'],
          // tenSP: data['tenSP'],
          // gia: data['gia'],
          // soluong: data['soluong'],
          // thanhtien: data['thanhtien'],
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
class ChiTietDonHang2 {
  final String tenSP;
  final int gia;
  final int soluong;
  final String url;
  ChiTietDonHang2({
    required this.tenSP,
    required this.gia,
    required this.soluong,
    required this.url
  });
  static Future<List<ChiTietDonHang2>> layChiTietDonHang(String donHangId) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('ChitietDH')
          .where('orderId', isEqualTo: donHangId)
          .get();

      print('Số lượng tài liệu: ${querySnapshot.size}');

      List<ChiTietDonHang2> chiTietDonHangList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ChiTietDonHang2(
          tenSP: data['tenSP'],
          gia: data['gia'].toInt(),
          soluong: data['soluong'].toInt(),
          url:data['url'],
        );
      }).toList();

      return chiTietDonHangList;
    } catch (e) {
      print('Lỗi khi lấy thông tin đơn hàng: $e');
      return [];
    }
  }

}