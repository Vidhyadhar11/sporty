import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporty/drawer/favorite.dart';
import 'package:sporty/drawer/rewards.dart';
import 'package:sporty/homepage/testpage.dart';
import 'package:sporty/login/enterphn.dart';
import 'package:sporty/uicomponents/cards.dart';
import 'package:sporty/booking/bookings1.dart';
import 'package:sporty/uicomponents/elements.dart';
import 'package:sporty/homepage/details.dart';
import 'package:sporty/drawer/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<SportsField> sportsFields = [
    SportsField(
      name: 'KPHB',
      location: 'Hyderabad',
      rating: 4.4,
      price: 120,
      imageUrl:
          'https://imgs.search.brave.com/zN2JDwLs9UxC0UGzY3mIqh_C1SxfAo6Vt5EUPwwRnMY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9hc3Ry/b3R1cmYuY29tL3N0/YXRpYy85NDMxNTZm/YmQ1ODg3NWEyMDZl/ZjdkMGMxMmJlY2Yz/NS8xM2U0My9VVFNB/LmpwZw', // Replace with your image URL
      discount: '15% Off',
      sportType: 'Football', // Pass the sportType
    ),
    SportsField(
      name: 'Gachibowli',
      location: 'Hyderabad',
      rating: 4.4,
      price: 120,
      imageUrl:
          'https://imgs.search.brave.com/zN2JDwLs9UxC0UGzY3mIqh_C1SxfAo6Vt5EUPwwRnMY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9hc3Ry/b3R1cmYuY29tL3N0/YXRpYy85NDMxNTZm/YmQ1ODg3NWEyMDZl/ZjdkMGMxMmJlY2Yz/NS8xM2U0My9VVFNB/LmpwZw', // Replace with your image URL
      discount: '10% Off',
      sportType: 'Cricket', // Pass the sportType
    ),
    SportsField(
      name: 'suchitra',
      location: 'chepak',
      rating: 4.4,
      price: 120,
      imageUrl:
          'https://imgs.search.brave.com/zN2JDwLs9UxC0UGzY3mIqh_C1SxfAo6Vt5EUPwwRnMY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9hc3Ry/b3R1cmYuY29tL3N0/YXRpYy85NDMxNTZm/YmQ1ODg3NWEyMDZl/ZjdkMGMxMmJlY2Yz/NS8xM2U0My9VVFNB/LmpwZw', // Replace with your image URL
      discount: '10% Off',
      sportType: 'Tennis', // Pass the sportType
    ),
    // Add more SportsField objects if needed
  ];

  List<SportsField> filteredSportsFields = [];
  bool isPressed =
      false; // Define isPressed variable at the beginning of _HomePageState class
  int _currentIndex = 0;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredSportsFields = sportsFields;
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
      filteredSportsFields = sportsFields.where((field) {
        return field.name.toLowerCase().contains(query) ||
            field.location.toLowerCase().contains(query) ||
            field.sportType.toLowerCase().contains(query);
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
                  Scaffold.of(context).openDrawer(); // Open the drawer
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
                Get.to(() => TestPage());
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[800],
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                // backgroundColor: Colors.grey[800],
                backgroundImage: NetworkImage('https://imgs.search.brave.com/EcbeGlqXlo-1UsUTCdkF0yVSwJa2x_xL3p66MTvzPns/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9hc3Nl/dHMtZ2xvYmFsLndl/YnNpdGUtZmlsZXMu/Y29tLzVlYzdkYWQy/ZTZmNjI5NWE5ZTJh/MjNkZC81ZWRmYTdj/NmY5NzhlNzUzNzJk/YzMzMmVfcHJvZmls/ZXBob3RvMS5qcGVn'),
              ),
              const SizedBox(height: 15),
              const Text('Salman Khan',
                  style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 10),
              const Text('salmankhan@gmail.com',
                  style: TextStyle(color: Colors.white)),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.grey,
              ),
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
                      Icon(Icons.favorite, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Liked',
                          style: TextStyle(color: Colors.white)),
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
              const ListTile(
                title: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.help, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Contact Support +91 9550249061', style: TextStyle(color: Colors.white,fontSize: 10.0)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: searchController,
                style: const TextStyle(
                    color: Colors.white),
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Interested Sport in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => TestPage());
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white),
                        Text(
                          'Location',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ...filteredSportsFields.map((field) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: SportsFieldCard(
                    sportsField: field,
                    onTap: () {
                      Get.to(() => DetailsPage(sportsField: field));
                    },
                  ),
                  ),
                ),
            const SizedBox(height: 200), // Adding space for the floating navbar
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
      ),
    );
  }
}
