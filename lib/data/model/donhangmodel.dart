import 'package:cloud_firestore/cloud_firestore.dart';

class Donhangmodel {
  String id;
  String idtk;
  String diachi;
  String tennguoinhan;
  String sdt;
  Trangthai trangthai;

  Donhangmodel({
    required this.id,
    required this.idtk,
    required this.diachi,
    required this.tennguoinhan,
    required this.sdt,
    required this.trangthai,
  });
  //
  // factory Donhang.fromDocumentSnapshot(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   return Donhang(
  //     id: doc.id,
  //     maSp: data['maSp'],
  //     idtk: data['idtk'],
  //     tenSP: data['tenSP'],
  //     gia: data['gia'],
  //     soluong: data['soluong'],
  //     thanhtien: data['thanhtien'],
  //     diachi: data['diachi'],
  //     tennguoinhan: data['tennguoinhan'],
  //     sdt: data['sdt'],
  //     trangthai: Trangthai.values[data['trangthai']],
  //   );
  // }
}

enum Trangthai {
  Choxacnhan,
  Chovanchuyen,
  Dangvanchuyen,
  Danggiao,
  Hoanthanh,
}
