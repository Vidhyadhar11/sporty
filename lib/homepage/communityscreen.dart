import 'package:flutter/material.dart';
import 'package:sporty/homepage/testpage.dart';
import 'package:sporty/uicomponents/elements.dart'; 

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  bool showPeople = true;

  List<Map<String, String>> people = [
     {'id': '1', 'name': 'Joms', 'description': 'cricket intermediate'},
    {'id': '2', 'name': 'Joms'},
    {'id': '3', 'name': 'Joms'},
    {'id': '4', 'name': 'Joms'},
    {'id': '5', 'name': 'vidhya'},
  ];
  
  List<Map<String, String>> groups = [
    {'id': '1', 'name': 'Cricket Enthusiasts', 'description': 'Join us for weekly cricket matches!'},
    {'id': '2', 'name': 'Football Fans', 'description': 'Weekly football games and discussions.'},
    {'id': '3', 'name': 'Tennis Club', 'description': 'Meet up for tennis matches and training.'},
  ];

  void addToGroup(Map<String, String> person) {
    if (!groups.contains(person)) {
      setState(() {
        person['time'] = TimeOfDay.now().format(context);
        groups.add(person);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            ToggleButton(
              leftLabel: 'People',
              rightLabel: 'Groups',
              onToggle: (isLeftSelected) {
                setState(() {
                  showPeople = isLeftSelected;
                });
              },
            ),
            Expanded(
              child: showPeople ? buildPeopleList() : buildGroupsList(),
            ),
          ],
        ),
        bottomNavigationBar: const CustomNavBar(currentIndex: 3), // Use CustomNavBar
      ),
    );
  }

  Widget buildPeopleList() {
    return ListView.separated(
      itemCount: people.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.black),
          ),
          title: Text(
            people[index]['name']!,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: people[index]['description'] != null
              ? Text(
                  people[index]['description']!,
                  style: const TextStyle(color: Colors.grey),
                )
              : null,
          trailing: TextButton(
            onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TestPage()),
            );
            },
            child: const Text(
              'add',
              style: TextStyle(color: Colors.green),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
          thickness: 0.5,
          height: 0.5,
          indent: 16.0,
          endIndent: 16.0,
        );
      },
    );
  }

  Widget buildGroupsList() {
    return ListView.separated(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.group, color: Colors.black),
          ),
          title: Text(
            groups[index]['name']!,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: groups[index]['description'] != null
              ? Text(
                  groups[index]['description']!,
                  style: const TextStyle(color: Colors.grey),
                )
              : null,
          trailing: TextButton(
            onPressed: () {
              // Join group logic here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Joined ${groups[index]['name']}')),
              );
            },
            child: const Text(
              'Join',
              style: TextStyle(color: Colors.green),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
          thickness: 0.5,
          height: 0.5,
          indent: 16.0,
          endIndent: 16.0,
        );
      },
    );
  }
}