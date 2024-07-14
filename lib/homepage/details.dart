import 'package:flutter/material.dart';
import 'package:sporty/uicomponents/cards.dart';
import 'package:sporty/booking/date.dart';
import 'package:get/get.dart';

class DetailsPage extends StatefulWidget { // Change to StatefulWidget
  final SportsField sportsField;
  final bool isFavorite;

  const DetailsPage({Key? key, required this.sportsField, this.isFavorite = false}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> { // Create State class
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.sportsField.imageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Location and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.sportsField.name}, ${widget.sportsField.location}',
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.people, color: Colors.green),
                          SizedBox(width: 5),
                          Text('3/8', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow),
                      const SizedBox(width: 5),
                      Text('${widget.sportsField.rating}', style: const TextStyle(color: Colors.white)),
                      const SizedBox(width: 10),
                      Text('₹${widget.sportsField.price}/hr', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Star Strikers
                  const Text(
                    'Star Strikers',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  // Amenities
                  const Text(
                    'Amenities',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.local_parking, color: Colors.white),
                          Text('Parking', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.restaurant, color: Colors.white),
                          Text('Cafeteria',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.accessibility, color: Colors.white),
                          Text('Rest Room',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.medical_services, color: Colors.white),
                          Text('First Aid Kit',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Rating
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 30),
                      SizedBox(width: 5),
                      Text('4.5',
                          style: TextStyle(color: Colors.white, fontSize: 24)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Reviews Placeholder
                  const Text(
                    'Reviews',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 200, // Adjust as needed
                    color: Colors.grey[900],
                    child: const Center(
                      child: Text(
                        'Reviews will be displayed here',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Back Arrow Button
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                // Handle back button press
                Navigator.pop(context);
              },
            ),
          ),
          // Floating section at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Heart icon and price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                        ),
                        onPressed: () {
                          // Join group logic here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Joined ${widget.sportsField.name}')),
                          );
                        },
                        child: Text('₹${widget.sportsField.price}/hr',
                            style: const TextStyle(color: Colors.black, fontSize: 20)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Book Now button
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Updated from primary
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () {
                        Get.to(() => BookingPage());
                      },
                      child: const Text('Book Now',
                          style: TextStyle(fontSize: 18, color: Colors.green)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}