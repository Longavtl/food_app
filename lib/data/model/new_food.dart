import 'package:cloud_firestore/cloud_firestore.dart';
class NewFood {
  final String maMon;
  final String tenMon;
  final double gia;
  final String moTa;
  final double sao;
  final String url;
  NewFood({
    required this.maMon,
    required this.tenMon,
    required this.gia,
    required this.moTa,
    required this.sao,
    required this.url
  });
  factory NewFood.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return NewFood(
      maMon: doc.id,
      tenMon: doc['tenMon'],
      gia: doc['gia'] ,
      moTa: doc['moTa'],
      sao: doc['sao'],
      url: doc['url'],
    );
  }
}