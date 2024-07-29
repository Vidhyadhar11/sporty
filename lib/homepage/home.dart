import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:sporty/homepage/testpage.dart';
import 'package:sporty/models/controllerhome.dart';
import 'package:sporty/uicomponents/elements.dart';

class HomePage extends StatelessWidget {
  final SportsFieldController controller = Get.put(SportsFieldController());

  HomePage({super.key});

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.sportsFields.length,
                  itemBuilder: (context, index) {
                    final field = controller.sportsFields[index];
                    return Card(
                      margin: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Image.network(field.imageUrl),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(field.category, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                Text('${field.turfName}, ${field.location}', style: const TextStyle(fontSize: 14.0)),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber),
                                    Text(field.rating.toString(), style: const TextStyle(fontSize: 14.0)),
                                  ],
                                ),
                                Text('₹${field.courts}/hr', style: const TextStyle(fontSize: 14.0)),
                                Text('${field.discounts}% Off', style: const TextStyle(fontSize: 14.0, color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
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