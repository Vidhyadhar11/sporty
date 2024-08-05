import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporty/drawer/drawerview.dart';
import 'package:sporty/homepage/details.dart';
import 'package:sporty/homepage/testpage.dart';
import 'package:sporty/models/controllerhome.dart';
import 'package:sporty/models/phncontroller.dart';
import 'package:sporty/models/sports_feild.dart';
import 'package:sporty/uicomponents/elements.dart';
import 'package:sporty/drawer/favorite.dart';
import 'package:sporty/drawer/rewards.dart';
import 'package:sporty/login/enterphn.dart';
import 'package:sporty/booking/bookings1.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SportsFieldController controller = Get.put(SportsFieldController());
  // final UserController userController = Get.put(UserController());
  TextEditingController searchController = TextEditingController();
  List<SportsFieldApi> filteredSportsFields = [];

  @override
  void initState() {
    super.initState();
    filteredSportsFields = controller.sportsFields;
    searchController.addListener(_filterSportsFields);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterSportsFields() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredSportsFields = controller.sportsFields.where((field) {
        return field.turfName.toLowerCase().contains(query) ||
            field.location.toLowerCase().contains(query) ||
            field.category.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false, // Ensure this is set to false
        title: Row(
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu,
                    color: Colors.white), // Set the color to white
                onPressed: () {
                  Scaffold.of(context).openDrawer(); 
                },
              ),
            ),
            const Text(
              'Play',
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              'link',
              style: TextStyle(color: Colors.green),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                Get.to(() => const TestPage());
              },
            ),
          ],
        ),
      ),
      drawer: Drawerview(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: filteredSportsFields.length,
                  itemBuilder: (context, index) {
                    final field = filteredSportsFields[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => DetailsPage(sportsField: field));
                      },
                      child: Card(
                        color: Colors.black,
                        margin: const EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                  ),
                                  child: Image.network(
                                    field.imageUrl,
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      field.category,
                                      style: const TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    field.turfName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    field.location,
                                    style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.amber, size: 18),
                                      const SizedBox(width: 4),
                                      Text(
                                        field.rating.toString(),
                                        style: const TextStyle(color: Colors.white, fontSize: 14.0),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '₹${field.courts}/hr',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
      bottomNavigationBar: const CustomNavBar(
        currentIndex: 0,
      ),
    );
  }
}
