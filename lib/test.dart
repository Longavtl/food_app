// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:food_app/data/model/Oder.dart';
// import 'package:food_app/data/model/data_repository.dart';
// import 'package:food_app/features/cart/bloc/cart_bloc.dart';
// import 'package:food_app/features/cart/bloc/cart_state.dart';
// class CartScreen1 extends StatefulWidget {
//   CartScreen1({Key? key}) : super(key: key);
//
//   @override
//   State<CartScreen1> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen1> {
//   @override
//   void initState() {
//     context.read<CartCubit>().initializeData(); // Khởi tạo dữ liệu ban đầu
//   }
//   @override
//   int thanhtien= 0;
//   UserSingleton userSingleton = UserSingleton.getInstance();
//   List<Oder> oders = [];
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//         title: Text('Cart'),),
//         body: BlocBuilder<CartCubit,List<Oder>>(
//           builder:(context, state) => ListView.builder(
//             itemCount: state.length,
//             itemBuilder: (context, index) {
//               Oder item = state[index];
//               return ListTile(
//                 leading: Image.network(
//                   item.url,
//                   height: 50,
//                 ),
//                 title: Text(item.tensp),
//                 subtitle: Text(item.gia.toString()+'.000 đ'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(item.soluong.toString()),
//                     IconButton(
//                       icon: Icon(Icons.delete),
//                         onPressed: () {
//                           // context.read<CartCubit>().emit([...oders]);
//                           context.read<CartCubit>().removeItem(item);
//                           // print(oders.remove(item));// Remove the item from the cart
//                           // deleteDocument(item.id); // Delete the item from Firestore
//                         }
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//     );
//
//   }
//   Future<void> readOders() async
//   {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('oders')
//           .where('user', isEqualTo: userSingleton.user.name)
//           .get();
//       querySnapshot.docs.forEach((doc) {
//         Oder oder= Oder.fromDocumentSnapshot(doc);
//         // setState(() {
//           oders.add(oder);
//         // });
//
//       });
//       oders.forEach((tt) {
//         print('User ID: ${tt.id}, Name: ${tt.gia}, Age: ${tt.user}');
//       });
//       userSingleton.number=oders.length;
//     } catch (e) {
//       print('Lỗi khi đọc dữ liệu: $e');
//     }
//   }
// }
