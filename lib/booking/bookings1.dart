import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporty/homepage/home.dart';
import 'package:sporty/uicomponents/elements.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool showUpcoming = true;
  bool isLoading = true;
  List<dynamic> bookings = [];

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    try {
      final response = await http.get(Uri.parse('https://10.0.2.2:3000/turfid'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('Bookings fetched successfully: $data');
        setState(() {
          bookings = data;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      print('Error fetching bookings: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Get.to(() => HomePage());
                      },
                    ),
                  ),
                  const Text(
                    'Bookings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ToggleButton(
                    leftLabel: 'Previous',
                    rightLabel: 'Upcoming',
                    onToggle: (isLeftSelected) {
                      setState(() {
                        showUpcoming = !isLeftSelected;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      var booking = bookings[index];
                      return BookingCard(
                        showUpcoming: showUpcoming,
                        imageUrl: booking['imageUrl'],
                        title: booking['title'],
                        location: booking['location'],
                        time: booking['time'],
                      );
                    },
                  ),
                ],
              ),
            ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final bool showUpcoming;
  final String imageUrl;
  final String title;
  final String location;
  final String time;

  const BookingCard({super.key, 
    required this.showUpcoming,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(imageUrl, width: 150, height: 150),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              showUpcoming ? '$title (Upcoming)' : '$title (Previous)',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(location, style: const TextStyle(color: Colors.white)),
            Text(time, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ],
    );
  }
}