import 'package:flutter/material.dart';
import 'package:sporty/screens/splash.dart'; // Import the splash screen
import 'package:sporty/screens/login.dart';
import 'package:sporty/screens/registration.dart';
import 'package:sporty/screens/forgot1.dart'; // Import the forgot password screen

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
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(), // Added route for forgot password screen
      },
    );
  }
}

