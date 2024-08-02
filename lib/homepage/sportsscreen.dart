import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporty/homepage/sports.dart';
import 'package:sporty/uicomponents/elements.dart';

class SportsScreen extends StatefulWidget {
  @override
  _SportsScreenState createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> sports = [
    {'name': 'Cricket', 'image': 'assets/Cricket-pana.png'},
    {'name': 'Badminton', 'image': 'assets/Badminton-bro.png'},
    {'name': 'Volleyball', 'image': 'assets/Beach volleyball-bro.png'},
    {'name': 'Soccer', 'image': 'assets/Soccer-bro.png'},
    {'name': 'Basketball', 'image': 'assets/basketball player-bro.png'},
    {'name': 'Swimming', 'image': 'assets/swimming.png'},
    {'name': 'Tennis', 'image': 'assets/Tennis-bro.png'},
    {'name': 'Golf', 'image': 'assets/Golf-bro.png'},
    {'name': 'Grand Slam', 'image': 'assets/Grand slam-bro.png'},
  ];

  void _onSportSelected(String sportName) {
    // Navigate to the new SportsScreen with the selected sport name
    Get.to(() => SportsListScreen(sportName: sportName));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Select Sport',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: sports.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _onSportSelected(sports[index]['name']!);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        image: DecorationImage(
                          image: AssetImage(sports[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0),
                            ),
                          ),
                          child: Text(
                            sports[index]['name']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomNavBar(currentIndex: 1),
      ),
    );
  }
}