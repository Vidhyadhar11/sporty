import 'package:flutter/material.dart';

class SportsField {
  final String name;
  final String location;
  final double rating;
  final double price;
  final String imageUrl;
  final String discount;

  SportsField({
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
    required this.imageUrl,
    required this.discount,
  });
}

class SportsFieldCard extends StatelessWidget {
  final SportsField sportsField;
  final VoidCallback onTap;

  const SportsFieldCard({Key? key, required this.sportsField, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                  child: Image.network(sportsField.imageUrl, height: 150, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    child: const Text('Football', style: TextStyle(color: Colors.white)),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    child: Text(sportsField.discount, style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${sportsField.name}, ${sportsField.location}', style: const TextStyle(color: Colors.white)),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 20),
                      const SizedBox(width: 5),
                      Text('${sportsField.rating}', style: const TextStyle(color: Colors.white)),
                      const SizedBox(width: 10),
                      Text('₹${sportsField.price}/hr', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Interested Sport in',
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
                          const SizedBox(width: 10),
                          const Icon(Icons.location_on, color: Colors.white),
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
                        onTap: () {},
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
          Positioned(
            bottom: 20,
            left: 60,
            right: 60,
            child: Opacity(
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
                      icon: const Icon(Icons.event, color: Colors.grey),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.people, color: Colors.grey),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData.dark(),
  ));
}
