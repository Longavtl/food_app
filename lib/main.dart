import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/features/home/ui/home_screen.dart';
import 'package:food_app/features/login/ui/login_screen.dart';
import 'package:food_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp(),);
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
      home: HomeScreen(),
    );
  }
}



