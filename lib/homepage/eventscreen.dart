import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:sporty/homepage/details.dart';
import 'package:sporty/homepage/testpage.dart';
import 'package:sporty/uicomponents/elements.dart';
import 'package:sporty/uicomponents/cards.dart';


class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool isJoinSelected = true;
  String selectedFilter = 'Filter';

  final List<SportsField> sportsFields = [
    SportsField(
      name: 'KPHB',
      location: 'Hyderabad',
      rating: 4.4,
      price: 120,
      imageUrl:
          'https://imgs.search.brave.com/zN2JDwLs9UxC0UGzY3mIqh_C1SxfAo6Vt5EUPwwRnMY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9hc3Ry/b3R1cmYuY29tL3N0/YXRpYy85NDMxNTZm/YmQ1ODg3NWEyMDZl/ZjdkMGMxMmJlY2Yz/NS8xM2U0My9VVFNB/LmpwZw', // Replace with your image URL
      discount: '15% Off',
      sportType: 'Football',
      slot: '6pm-7pm',
      players: 3,
      maxPlayers: 8,
    ),
    SportsField(
      name: 'KPHB',
      location: 'Hyderabad',
      rating: 4.4,
      price: 120,
      imageUrl:
          'https://imgs.search.brave.com/zN2JDwLs9UxC0UGzY3mIqh_C1SxfAo6Vt5EUPwwRnMY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9hc3Ry/b3R1cmYuY29tL3N0/YXRpYy85NDMxNTZm/YmQ1ODg3NWEyMDZl/ZjdkMGMxMmJlY2Yz/NS8xM2U0My9VVFNB/LmpwZw', // Replace with your image URL
      discount: '15% Off',
      sportType: 'Football',
      slot: '6pm-7pm',
      players: 5,
      maxPlayers: 8,
    ),
    // Add more SportsField objects as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            // Toggle Button
            Center(
              child: ToggleButton(
                leftLabel: 'Join',
                rightLabel: 'Competition',
                onToggle: (isLeftSelected) {
                  setState(() {
                    isJoinSelected = isLeftSelected;
                  });
                },
              ),
            ),
            // Filter and Location Row
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      popupMenuTheme: const PopupMenuThemeData(
                        color: Color(0xFF2C2C2C),
                      ),
                    ),
                    child: PopupMenuButton<String>(
                      onSelected: (String value) {
                        setState(() {
                          selectedFilter = value;
                        });
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem<String>(
                            value: 'football',
                            child:  Text('football',style: TextStyle(color: Colors.white)),
                          ),
                          const PopupMenuItem<String>(
                            value: 'tennis',
                            child: Text('tennis',style: TextStyle(color: Colors.white)),
                          ),
                          const PopupMenuItem<String>(
                            value: 'badminton',
                            child: Text('badminton',style: TextStyle(color: Colors.white)),
                          ),
                          const PopupMenuItem<String>(
                            value: 'golf',
                            child: Text('golf',style: TextStyle(color: Colors.white)),
                          ),
                          const PopupMenuItem<String>(
                            value: 'cricket',
                            child: Text('cricket',style: TextStyle(color: Colors.white)),
                          ),
                          const PopupMenuItem<String>(
                            value: 'swimming',
                            child: Text('swimming',style: TextStyle(color: Colors.white)),
                          ),
                          const PopupMenuItem<String>(
                            value: 'basketball',
                            child: Text('basketball',style: TextStyle(color: Colors.white)),
                          ),
                        ];
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(selectedFilter, style: const TextStyle(color: Colors.white)),
                            const Icon(Icons.arrow_drop_down, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                        Get.to(() => const TestPage());
                    },
                    icon: const Icon(Icons.location_on, color: Colors.white),
                    label: const Text('Location', style: TextStyle(color: Colors.white)),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Use your existing event cards or other widgets here
            Expanded(
              child: isJoinSelected 
                ? JoinEvents(sportsFields: sportsFields) 
                : CompeteEvents(sportsFields: sportsFields),
            ),
          ],
        ),
        bottomNavigationBar: const CustomNavBar(currentIndex: 2),
      ),
    );
  }
}

class JoinEvents extends StatelessWidget {
  final List<SportsField> sportsFields;

  const JoinEvents({super.key, required this.sportsFields});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sportsFields.length,
      itemBuilder: (context, index) {
        return SportsFieldCardV2(
          sportsField: sportsFields[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(
                  sportsField: sportsFields[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CompeteEvents extends StatelessWidget {
  final List<SportsField> sportsFields;

  const CompeteEvents({super.key, required this.sportsFields});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sportsFields.length,
      itemBuilder: (context, index) {
        return SportsFieldCardV3(
          sportsField: sportsFields[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(
                  sportsField: sportsFields[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}