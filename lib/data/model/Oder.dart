import 'package:cloud_firestore/cloud_firestore.dart';
class Oder {
  final String id;
  final String tensp;
  final int gia;
  final int  soluong;
  final String user;
  final String url;

  Oder({required this.id, required this.tensp, required this.gia, required this.soluong,required this.user,required this.url});
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
}

