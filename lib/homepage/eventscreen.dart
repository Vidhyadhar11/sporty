import 'package:flutter/material.dart';
import 'package:sporty/homepage/details.dart';
import 'package:sporty/uicomponents/elements.dart';
import 'package:sporty/uicomponents/cards.dart';

class EventScreen extends StatefulWidget {
  @override
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
      imageUrl: 'https://example.com/image1.jpg',
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
      imageUrl: 'https://example.com/image2.jpg',
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Toggle Button
          Center(
            child: ToggleButton(
              leftLabel: 'Join',
              rightLabel: 'Compete',
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
                    popupMenuTheme: PopupMenuThemeData(
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
                          child: const Text('football',style: TextStyle(color: Colors.white)),
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
                    // Handle location action
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
            child: SingleChildScrollView(
              child: isJoinSelected 
                ? JoinEvents(sportsFields: sportsFields) 
                : CompeteEvents(sportsFields: sportsFields),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 2),
    );
  }
}

class JoinEvents extends StatelessWidget {
  final List<SportsField> sportsFields;

  JoinEvents({required this.sportsFields});

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

  CompeteEvents({required this.sportsFields});

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