import 'package:flutter/material.dart';
import 'package:sporty/models/sports_feild.dart';
import 'package:sporty/uicomponents/cards.dart';
import 'package:sporty/booking/date.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailsPage extends StatefulWidget { // Change to StatefulWidget
  SportsField sportsField;
  final bool isFavorite;

  DetailsPage({super.key, required this.sportsField, this.isFavorite = false});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late bool isFavorite;
  bool isLoading = true; // To track loading state
  SportsFieldApi? details;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
    fetchFieldDetails();
  }

  Future<void> fetchFieldDetails() async {
    try {
      final response = await http.get(Uri.parse('https://e952-39-41-236-138.ngrok-free.app/turfid'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          details = SportsFieldApi.fromJson(data);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load sports field details');
      }
    } catch (e) {
      print('Error fetching sports field details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : Stack(
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
                            // Decode the base64 string to image
                            image: MemoryImage(base64Decode(details!.imageUrl)),
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
                            '${details!.turfName}, ${details!.location}',
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
                          Text('${details!.rating}', style: const TextStyle(color: Colors.white)),
                          const SizedBox(width: 10),
                          Text('₹${details!.slots[0]['price']}/hr', style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      Text(
                        details!.turfName, // Use the turfName from the details object
                        style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)
                      ),
                      const SizedBox(height: 10),
                      Text(
                        details!.description,
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
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
                      Wrap(
                        spacing: 10, // Horizontal space between chips
                        runSpacing: 10, // Vertical space between chips
                        children: details!.amenities.map((amenity) => Chip(
                          label: Text(amenity, style: const TextStyle(color: Colors.white)),
                          backgroundColor: Colors.black,
                          avatar: const Icon(
                            Icons.check, // Example icon, you might want to customize
                            color: Colors.white,
                          ),
                        )).toList(),
                      ),
                      const SizedBox(height: 20),
                      // Rating
                       Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow, size: 30),
                          const SizedBox(width: 5),
                          Text(
                            '${details!.rating}', // Use the rating from the details object
                            style: const TextStyle(color: Colors.white, fontSize: 24)
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Reviews Placeholder
                      const Text('Reviews',style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Container(
                        height: 200, // Adjust as needed
                        color: Colors.grey[900],
                        child: const Center(
                          child: Text('Reviews will be displayed here',style: TextStyle(color: Colors.grey)),
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
                                SnackBar(content: Text('Joined ${details!.turfName}')),
                              );
                            },
                            child: Text('₹${details!.slots[0]['price']}/hr',
                                style: const TextStyle(color: Colors.black, fontSize: 20)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Book Now button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () {
                            Get.to(() => BookingPage(turfRate: details!.slots[0]['price']));
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