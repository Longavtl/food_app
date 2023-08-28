import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/home/bloc/home_bloc.dart';
import 'package:food_app/features/home/bloc/home_state.dart';
import 'package:food_app/features/home/ui/widget_child/drawer_home.dart';
import 'package:food_app/features/home/ui/widget_child/home_chid.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  List<Widget> _widgetOptions() {
    return <Widget>[
      HomeChild(),
      // Search(search: ''),
      Text(
        'Search',
      ),
      Text(
        'Favorite',
      ),
      Text(
        'Profile',
      ),
    ];
  }
  final HomeBloc homeBloc= HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: homeBloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Home page'),
            ),
            drawer: DrawerHome(),
            body: _widgetOptions().elementAt(_selectedIndex),
            bottomNavigationBar: GNav(curve: Curves.easeOutExpo, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),// tab animation curves
              duration: Duration(milliseconds: 900),backgroundColor: Colors.blue,color: Colors.white,iconSize: 20,activeColor: Colors.white,tabBackgroundColor: Color.fromRGBO(168, 209, 252, 50),tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Favorite',
                ),
                GButton(
                  icon: Icons.verified_user,
                  text: 'Profile',
                )
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },),
          );
        },
        listener:(context, state) {
          if(state is HomeToHomeScreenState)
            {

            }
        },);
  }
}
