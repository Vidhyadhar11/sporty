import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sporty/models/controllerhome.dart';
import 'package:sporty/uicomponents/cards.dart'; 
class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final LikedFieldsController likedController = Get.find<LikedFieldsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liked Fields'),
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
              title: Text(field.turfName),
              subtitle: Text(field.location),
              trailing: IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: () => likedController.toggleLike(field),
              ),
            );
          },
        );
      }),
    );
  }
}