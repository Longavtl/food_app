import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/cart/ui/cart_screen.dart';
import 'package:food_app/features/chitiet_food/bloc/chitiet_bloc.dart';
import 'package:food_app/features/home_page/home/bloc/home_bloc.dart';
import 'package:food_app/features/home_page/home/ui/home_screen.dart';
import 'package:food_app/features/login/ui/login_screen.dart';
import 'package:food_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_app/test.dart';

import 'features/cart/bloc/cart_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<ChiTietBloc>(create: (context) => ChiTietBloc()),
      BlocProvider<CartCubit>(
        create: (context) => CartCubit(),
      ),
      BlocProvider<CounterCubit>(
        create: (context) => CounterCubit(),
        // Các Bloc khác
      )
    ], child: MyApp()),
  );
  debugPrintGestureArenaDiagnostics = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
        primaryColor: Colors.teal,
        pageTransitionsTheme: PageTransitionsTheme(
        builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
        ),
        ),
      home:HomeScreen(),
    );
  }
}



