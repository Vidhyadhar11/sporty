import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:sporty/booking/bookings1.dart';
import 'package:sporty/homepage/home.dart';
import 'package:sporty/login/enterphn.dart';
import 'package:sporty/login/splash.dart';
import 'package:sporty/models/controllerhome.dart';

// import 'package:sporty/payment/singlepay.dart';

void main() {
  Get.put(LikedFieldsController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sporty App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/onboarding', page: () => const SplashScreen()),
        GetPage(name: '/enter-phone', page: () => const EnterPhoneNumberScreen()),
        GetPage(name: '/', page: () => HomePage()),
      ],
    );
  }
}