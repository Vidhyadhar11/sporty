import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SportsField {
  final String name;
  final String location;
  final double rating;
  final double price;
  final String imageUrl;
  final String discount;

  SportsField({
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
    required this.imageUrl,
    required this.discount,
  });
}

class SportsFieldCard extends StatelessWidget {
  final SportsField sportsField;
  final VoidCallback onTap;

  const SportsFieldCard({Key? key, required this.sportsField, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                  child: Image.network(sportsField.imageUrl, height: 150, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    child: const Text('Football', style: TextStyle(color: Colors.white)),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    child: Text(sportsField.discount, style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${sportsField.name}, ${sportsField.location}', style: const TextStyle(color: Colors.white)),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 20),
                      const SizedBox(width: 5),
                      Text('${sportsField.rating}', style: const TextStyle(color: Colors.white)),
                      const SizedBox(width: 10),
                      Text('₹${sportsField.price}/hr', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
