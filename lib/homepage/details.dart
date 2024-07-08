


import 'package:flutter/material.dart';
import 'package:sporty/uicomponents/cards.dart';

class DetailsPage extends StatelessWidget {
  final SportsField sportsField;

  const DetailsPage({Key? key, required this.sportsField}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${sportsField.name}, ${sportsField.location}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(sportsField.imageUrl),
            const SizedBox(height: 10),
            Text('Rating: ${sportsField.rating}'),
            Text('Price: ₹${sportsField.price}/hr'),
            Text('Discount: ${sportsField.discount}'),
          ],
        ),
      ),
    );
  }
}
