import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sporty/uicomponents/cards.dart'; // Adjust the import according to your project structure

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<SportsField> favoritesList = [];

  void addToFavorites(SportsField sportsField) {
    setState(() {
      favoritesList.add(sportsField);
    });
  }
  void removeFromFavorites(SportsField sportsField) {
    setState(() {
      favoritesList.remove(sportsField);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.green, size: 24,),
              onPressed: () => Navigator.pop(context), 
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.3,),
              const Text("Liked",
              style: TextStyle(color: Colors.green,
              fontSize: 24,
              decoration: TextDecoration.none,),)
            ],
          ),
          Expanded( // Added Expanded to allow ListView to take available space
            child: ListView.builder(
              itemCount: favoritesList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favoritesList[index].name), // Adjust according to your SportsField model
                  // Add other properties of SportsField as needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}