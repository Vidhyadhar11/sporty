import 'package:flutter/material.dart';
import 'package:sporty/screens/login.dart'; // Import your login screen

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Navigate to the login screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/assets/file_2024-06-17_16.48.13.png', height: 70), // Corrected file path
      ),
    );
  }
}
