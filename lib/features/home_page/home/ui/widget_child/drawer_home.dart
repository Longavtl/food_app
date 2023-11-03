import 'package:flutter/material.dart';
import 'package:food_app/data/model/GoogleSignInManager.dart';
import 'package:food_app/data/model/Oder.dart';
import 'package:food_app/data/model/data_repository.dart';
import 'package:food_app/features/cart/ui/cart_screen.dart';
import 'package:food_app/features/login/ui/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DrawerHome extends StatefulWidget {
  const DrawerHome({
    super.key,
  });

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  @override
  List<Oder> oders = [];
  UserSingleton userSingleton = UserSingleton.getInstance();
  void initState() {
    super.initState();
    readOders();
  }
  Widget build(BuildContext context) {
    UserSingleton userSingleton = UserSingleton.getInstance();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Well come '+userSingleton.user.name),
            accountEmail: Text(userSingleton.user.email),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  userSingleton.urlImage.startsWith('http') ? userSingleton.urlImage : 'https://firebasestorage.googleapis.com/v0/b/fir-235c2.appspot.com/o/user.png?alt=media&token=a9796ec1-e1a8-4861-9e80-7e2e4fa0af0f',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),

          ListTile(
              leading: Icon(Icons.favorite,color: Colors.blue),
              title:  Text('Favorite'),//
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => Favorite(),));
              }
          ),
          ListTile(
            leading: Icon(Icons.person,color: Colors.blue),
            title: Text('Protifile'),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => Protifile( user: user),));
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications,color: Colors.blue),
            title: Text('Request'),
          ),
          ListTile(
            leading: Stack(
              children: [
                Icon(Icons.shopping_cart_sharp,color: Colors.blue),
                if(userSingleton.number>0)
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.red, // Màu đỏ
                    radius: 8.0, // Độ lớn của hình tròn
                    child: Text(
                      userSingleton.number.toString(), // Số lượng (thay thế bằng số lượng thực tế)
                      style: TextStyle(
                        color: Colors.white, // Màu chữ
                        fontSize: 10.0, // Kích thước chữ
                      ),
                    ),
                  ),
                ),
              ],
            ),
            title: Text('Cart'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen(),
                ),
              );
            },
          ),
          Divider(),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings,color: Colors.blue),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
              title: Text('Log out'),
              leading: Icon(Icons.exit_to_app,color: Colors.blue),
              onTap: (){
                GoogleSignInManager ggSign=GoogleSignInManager();
                ggSign.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginIn(),
                  ),
                );
              }
          ),
          ListTile(
              leading: Icon(Icons.question_answer_sharp,color: Colors.blue),
              title: Text('About'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AboutScreen(),
                //   ),
                // );
              }
          ),
        ],
      ),
    );
  }

  Future<void> readOders() async
  {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('oders')
          .where('user', isEqualTo: userSingleton.user.name)
          .get();
      querySnapshot.docs.forEach((doc) {
        Oder oder= Oder.fromDocumentSnapshot(doc);
          oders.add(oder);
      });
      setState(() {
        userSingleton.number=oders.length;
      });
    } catch (e) {
      print('Lỗi khi đọc dữ liệu: $e');
    }
  }
}

