import 'package:flutter/material.dart';
import 'package:sporty/uicomponents/elements.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';  
// import 'package:sporty/homepage/testpage.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  bool showPeople = true;
  List<Map<String, dynamic>> people = [];
  List<Map<String, dynamic>> groups = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPeople();
    fetchGroups();
  }

  Future<void> fetchPeople() async {
    try {
      final response = await http.get(Uri.parse('http://13.233.98.192:3000/users'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          people = data.cast<Map<String, dynamic>>();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load people');
      }
    } catch (e) {
      print('Error fetching people: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchGroups() async {
    try {
      final response = await http.get(Uri.parse('http://13.233.98.192:3000/community-group'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          groups = data.cast<Map<String, dynamic>>();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load groups');
      }
    } catch (e) {
      print('Error fetching groups: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void launchWhatsApp(String phoneNumber) async {
    // Remove any non-digit characters from the phone number
    phoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    
    // Construct the WhatsApp URL
    final whatsappUrl = "https://wa.me/$phoneNumber";
    
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      print('Could not launch WhatsApp');
      // You might want to show a snackbar or dialog here to inform the user
    }
  }

  Future<void> launchUrl(Uri url) async {
    if (!await canLaunch(url.toString())) {
      throw 'Could not launch $url';
    }
    await launch(url.toString());
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
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : showPeople ? buildPeopleList() : buildGroupsList(),
            ),
          ],
        ),
        bottomNavigationBar: const CustomNavBar(currentIndex: 3),
      ),
    );
  }

  Widget buildPeopleList() {
    return ListView.separated(
      itemCount: people.length,
      itemBuilder: (context, index) {
        final person = people[index];
        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.black),
          ),
          title: Text(
            person['firstname'] ?? 'Unknown',
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            '${person['intrestedsports'] ?? 'No sport'} - ${person['level'] ?? 'No level'}',
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: TextButton(
            onPressed: () {
              // Check if the 'mobileno' field exists and is not empty
              if (person['mobileno'] != null && person['mobileno'].isNotEmpty) {
                launchWhatsApp(person['mobileno']);
              } else {
                // Show a message if the phone number is not available
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Phone number not available for ${person['firstname']}')),
                );
              }
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
        final group = groups[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(group['profileImage']),
          ),
          title: Text(
            group['title'] ?? 'Unknown Group',
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            group['subtitle'] ?? 'No description',
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: TextButton(
            onPressed: () {
              // Use the 'grouplink' field to open the group link
              if (group['groupLink'] != null) {
                launchUrl(Uri.parse(group['groupLink']));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No group link available')),
                );
              }
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