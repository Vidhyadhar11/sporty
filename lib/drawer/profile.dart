import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userName;
  final String email;
  final String phoneNumber;
  final int matchesPlayed; // Assuming you have a way to get this data

  const ProfilePage({
    Key? key,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.matchesPlayed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.green),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/playlink.jpg'),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.green),
                title: Text('Username: $userName',
                    style: const TextStyle(color: Colors.white)),
              ),
              const Divider(color: Colors.grey),
              ListTile(
                leading: const Icon(Icons.email, color: Colors.green),
                title: Text('Email: $email',
                    style: const TextStyle(color: Colors.white)),
              ),
              const Divider(color: Colors.grey),
              ListTile(
                leading: const Icon(Icons.phone, color: Colors.green),
                title: Text('Phone Number: $phoneNumber',
                    style: const TextStyle(color: Colors.white)),
              ),
              const Divider(color: Colors.grey),
              ListTile(
                leading: const Icon(Icons.sports_soccer, color: Colors.green),
                title: Text('Matches Played: $matchesPlayed',
                    style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
