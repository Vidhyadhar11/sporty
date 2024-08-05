import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sporty/drawer/drawerview.dart';
import 'package:sporty/homepage/eventscreen.dart';
import 'package:sporty/homepage/home.dart';
import 'package:sporty/login/enterphn.dart';
import 'package:sporty/login/splash.dart';
import 'package:sporty/models/controllerhome.dart';
import 'package:sporty/models/mycontroller.dart';
import 'package:sporty/payment/razorpay.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(LikedFieldsController());
  Get.put(RazorpayService());

  
  // Initialize Mycontroller first
  Get.put(Mycontroller());
  
  // Then initialize UserController
  Get.put(UserController());
  
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
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/enter-phone', page: () => const EnterPhoneNumberScreen()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
    );
  }
}