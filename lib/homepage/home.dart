import 'package:flutter/material.dart';
import 'package:sporty/uicomponents/cards.dart';
import 'package:sporty/homepage/bookings1.dart';

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

  bool _showDrawer = false;
  bool isPressed = false; // Define isPressed variable at the beginning of _HomePageState class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                setState(() {
                  _showDrawer = !_showDrawer;
                });
              },
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
          if (_showDrawer)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height,
                color: Colors.black,
                child: Drawer(
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
              ),
            ),
        ],
      ),
      bottomNavigationBar: Opacity(
        opacity: 0.9,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.green),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.sports_soccer, color: Colors.grey),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.event,
                  color: isPressed ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isPressed = true;
                  });
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => eventscreen()),
                  // );
                },
              ),

              IconButton(
                icon: const Icon(Icons.people, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final SportsField sportsField;

  const DetailsPage({Key? key, required this.sportsField}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${sportsField.name}, ${sportsField.location}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(sportsField.imageUrl),
            const SizedBox(height: 10),
            Text('Rating: ${sportsField.rating}'),
            Text('Price: ₹${sportsField.price}/hr'),
            Text('Discount: ${sportsField.discount}'),
          ],
        ),
      ),
    );
  }
}
