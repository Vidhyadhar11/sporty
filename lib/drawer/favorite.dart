import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporty/models/controllerhome.dart';
import 'package:sporty/homepage/details.dart';

class FavoriteScreen extends StatelessWidget {
  final LikedFieldsController likedController = Get.find<LikedFieldsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Liked Fields', style: TextStyle(color: Colors.green)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (likedController.likedFields.isEmpty) {
          return Center(child: Text('No liked fields yet'));
        }
        return ListView.builder(
          itemCount: likedController.likedFields.length,
          itemBuilder: (context, index) {
            final field = likedController.likedFields[index];
            return ListTile(
              leading: Image.network(field.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(field.turfName, style: TextStyle(color: Colors.white)),
              subtitle: Text(field.location, style: TextStyle(color: Colors.white)),
              trailing: IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: () => likedController.toggleLike(field),
              ),
              onTap: () {
                Get.to(() => DetailsPage(sportsField: field));
              },
            );
          },
        );
      }),
    );
  }
}