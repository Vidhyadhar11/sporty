import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporty/drawer/drawercon.dart';
import 'package:sporty/booking/bookings1.dart';
import 'package:sporty/drawer/favorite.dart';
import 'package:sporty/drawer/rewards.dart';
import 'package:sporty/login/enterphn.dart';

class DrawerView extends StatelessWidget {
  final UserController userController = Get.find<UserController>();

  DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[800],
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => GestureDetector(
              onTap: () {
                // Implement image picker functionality here
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(userController.user.value.profile),
              ),
            )),
            const SizedBox(height: 15),
            Obx(() => Text(
              '${userController.user.value.firstname} ${userController.user.value.lastname}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            )),
            const SizedBox(height: 10),
            Obx(() => Text(
              userController.user.value.intrestedsports,
              style: const TextStyle(color: Colors.white),
            )),
            const SizedBox(height: 5),
            Obx(() => Text(
              'Level: ${userController.user.value.level}',
              style: const TextStyle(color: Colors.white),
            )),
            const SizedBox(height: 5),
            Obx(() => Text(
              'Age: ${userController.user.value.age}',
              style: const TextStyle(color: Colors.white),
            )),
            const SizedBox(height: 10),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            ListTile(
              title: const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.book, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Bookings', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              onTap: () {
                Get.to(() => BookingScreen());
              },
            ),
            ListTile(
              title: const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.star, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Rewards', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              onTap: () {
                Get.to(() => RewardsPage());
              },
            ),
            ListTile(
              title: const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.star, color: Colors.white),
                    SizedBox(width: 8),
                    Text('liked', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              onTap: () {
                Get.to(() => FavoriteScreen());
              },
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                title: const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.logout, color: Colors.green),
                      SizedBox(width: 8),
                      Text('Logout', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
                onTap: () {
                  Get.to(() => EnterPhoneNumberScreen());
                },
              ),
            ),
            ListTile(
              title: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.help, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Contact Support 9550249061',
                        style: TextStyle(color: Colors.white, fontSize: 10.0)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
