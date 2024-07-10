// home_page.dart

import 'package:flutter/material.dart';
//import 'package:sporty/homepage/communityscreen.dart';
import 'package:sporty/uicomponents/cards.dart';
import 'package:sporty/booking/bookings1.dart';
import 'package:sporty/uicomponents/elements.dart';
import 'package:sporty/homepage/details.dart'; // Import the custom navbar

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
      imageUrl: 'https://via.placeholder.com/150', // Replace with your image URL
      discount: '15% Off',
      sportType: 'Football', // Pass the sportType
    ),
    SportsField(
      name: 'Gachibowli',
      location: 'Hyderabad',
      rating: 4.4,
      price: 120,
      imageUrl: 'https://via.placeholder.com/150', // Replace with your image URL
      discount: '10% Off',
      sportType: 'Cricket', // Pass the sportType
    ),
    SportsField(
      name: 'suchitra',
      location: 'chepak',
      rating: 4.4,
      price: 120,
      imageUrl: 'https://via.placeholder.com/150', // Replace with your image URL
      discount: '10% Off',
      sportType: 'Tennis', // Pass the sportType
    ),
    // Add more SportsField objects if needed
  ];

  List<SportsField> filteredSportsFields = [];
  bool isPressed = false; // Define isPressed variable at the beginning of _HomePageState class
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
                icon: const Icon(Icons.menu, color: Colors.white), // Set the color to white
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
              onPressed: () {},
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Salman Khan', style: TextStyle(color: Colors.white)),
              accountEmail: const Text('salmankhan@gmail.com', style: TextStyle(color: Colors.white)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey[800],
                child: const Icon(Icons.person, color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[900],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: Center(child: const Text('Your Profile', style: TextStyle(color: Colors.white))),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.book, color: Colors.white),
              title: Center(child: const Text('Bookings', style: TextStyle(color: Colors.white))),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.white),
              title: Center(child: const Text('Rewards', style: TextStyle(color: Colors.white))),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.white),
              title: Center(child: const Text('Your Wishlist', style: TextStyle(color: Colors.white))),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.help, color: Colors.white),
              title: Center(child: const Text('Help desk', style: TextStyle(color: Colors.white))),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: Center(child: const Text('Settings', style: TextStyle(color: Colors.white))),
              onTap: () {},
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.green),
                title: Center(child: const Text('Logout', style: TextStyle(color: Colors.green))),
                onTap: () {
                  // Handle logout logic
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: searchController,
                style: TextStyle(color: Colors.white), // Set the text color to white
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Interested Sport in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
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
            ...filteredSportsFields.map((field) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SportsFieldCard(
                sportsField: field,
                onTap: () {
                  // Handle the click event, e.g., navigate to the details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(sportsField: field),
                    ),
                  );
                },
              ),
            )),
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