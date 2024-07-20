import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Favorites'),
        titleTextStyle: const TextStyle(
          color: Colors.green,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: favoritesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoritesList[index].name), // Adjust according to your SportsField model
            // Add other properties of SportsField as needed
          );
        },
      ),
    );
  }
}
