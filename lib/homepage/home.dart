// home_page.dart

import 'package:flutter/material.dart';
import 'package:sporty/uicomponents/cards.dart';
import 'package:sporty/homepage/bookings1.dart';
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
    ),
    SportsField(
      name: 'KPHB',
      location: 'Hyderabad',
      rating: 4.4,
      price: 120,
      imageUrl: 'https://via.placeholder.com/150', // Replace with your image URL
      discount: '10% Off',
    ),
    // Add more SportsField objects if needed
  ];

  // bool _showDrawer = false;
  bool isPressed = false; // Define isPressed variable at the beginning of _HomePageState class
  int _currentIndex = 0;

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Navigate to different screens based on the index
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        // automaticallyImplyLeading: false,
        title: Row(
          children: [
            // IconButton(
            //   icon: const Icon(Icons.menu, color: Colors.white),
            //   onPressed: () {
            //     setState(() {
            //       ;
            //     });
            //   },
            // ),
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
        child: ListView(
          padding: EdgeInsets.zero,
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
              title: const Text('Your Profile', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.book, color: Colors.white),
              title: const Text('Bookings', style: TextStyle(color: Colors.white)),
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
              title: const Text('Rewards', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.white),
              title: const Text('Your Wishlist', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.help, color: Colors.white),
              title: const Text('Help desk', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text('Settings', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text('Logout', style: TextStyle(color: Colors.green)),
              onTap: () {
                // Handle logout logic
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Interested Sport in',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.location_on, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
            ...sportsFields.map((field) => Padding(
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
        // onTap: _onNavBarTap,
      ),
    );
  }
}