import 'package:cloud_firestore/cloud_firestore.dart';

class Oder {
  final String id;
  final String tensp;
  final int gia;
  final int soluong;
  final String user;
  final String url;
  bool check;

  Oder({
    required this.id,
    required this.tensp,
    required this.gia,
    required this.soluong,
    required this.user,
    required this.url,
    bool check = false, // Cung cấp giá trị mặc định trong constructor
  }) : check = check; // Khởi tạo check với giá trị được cung cấp

  factory Oder.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Oder(
      id: doc.id,
      gia: data['gia'].toInt(),
      soluong: data['soluong'].toInt(),
      tensp: data['tensp'],
      user: data['user'],
      url: data['url'],
    );
  }
  @override
  String toString() {
    return 'ID: $id, Tên SP: $tensp, Giá: $gia, Số lượng: $soluong, User: $user, URL: $url, Đã chọn: $check';
  }
  // Phương thức setter cho check
  void setCheck(bool value) {
    check = value;
  }
}
