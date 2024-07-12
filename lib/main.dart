import 'package:flutter/material.dart';
//import 'package:sporty/homepage/home.dart';
// import 'package:sporty/login/enterphn.dart';
import 'package:sporty/login/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sporty App',
      initialRoute: '/',
      routes: {
         '/': (context) => const SplashScreen(),
       //'/enter-phone': (context) => EnterPhoneNumberScreen(),
       //'/home': (context) => HomePage(),
      },
    );
  }
}
