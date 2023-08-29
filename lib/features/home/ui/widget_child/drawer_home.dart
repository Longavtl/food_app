import 'package:flutter/material.dart';
import 'package:food_app/data/model/data_repository.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({
    super.key,
  });
  @override
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
                   'https://firebasestorage.googleapis.com/v0/b/fir-235c2.appspot.com/o/user.png?alt=media&token=a9796ec1-e1a8-4861-9e80-7e2e4fa0af0f',
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
              leading: Icon(Icons.favorite),
              title:  Text('Favorite'),//
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => Favorite(),));
              }
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Protifile'),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => Protifile( user: user),));
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Request'),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart_sharp),
            title: Text('Cart'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => CartScreen(name: user.name),
              //   ),
              // );
            },
          ),
          Divider(),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
              title: Text('Log out'),
              leading: Icon(Icons.exit_to_app),
              onTap: (){
                // LoginIn Logout=LoginIn();
                // Logout.Logout();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => LoginIn(),
                //   ),
                // );
              }
          ),
          ListTile(
              leading: Icon(Icons.question_answer_sharp),
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
}
