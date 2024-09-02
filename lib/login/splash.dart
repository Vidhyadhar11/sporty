import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporty/homepage/home.dart';
import 'package:sporty/login/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? finalPhoneNumber;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phoneNumber = prefs.getString('phoneNumber');
    
    var obtainedPhoneNumber = phoneNumber;
    setState(() {
      finalPhoneNumber = obtainedPhoneNumber;
    });
    // Navigate after checking status
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => finalPhoneNumber == null ? const Onboarding() : const HomePage()
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/playlink.png', height: 250),
      ),
    );
  }
}