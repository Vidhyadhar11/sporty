// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:sporty/models/controllerhome.dart';
// // import 'package:sporty/homepage/details.dart';

// // class FavoriteScreen extends StatelessWidget {
// //   final LikedFieldsController likedController = Get.find<LikedFieldsController>();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       appBar: AppBar(
// //         backgroundColor: Colors.black,
// //         title: const Text('Liked Fields', style: TextStyle(color: Colors.green)),
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: Colors.green),
// //           onPressed: () => Get.back(),
// //         ),
// //       ),
// //       body: Obx(() {
// //         if (likedController.likedFields.isEmpty) {
// //           return const Center(child: Text('No liked fields yet', style: TextStyle(color: Colors.white)));
// //         }
// //         return ListView.builder(
// //           itemCount: likedController.likedFields.length,
// //           itemBuilder: (context, index) {
// //             final field = likedController.likedFields[index];
// //             return ListTile(
// //               leading: Image.network(field.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
// //               title: Text(field.turfName, style: const TextStyle(color: Colors.white)),
// //               subtitle: Text(field.location, style: const TextStyle(color: Colors.white)),
// //               trailing: IconButton(
// //                 icon: const Icon(Icons.favorite, color: Colors.red),
// //                 onPressed: () => likedController.toggleLike(field),
// //               ),
// //               onTap: () {
// //                 Get.to(() => DetailsPage(sportsField: field));
// //               },
// //             );
// //           },
// //         );
// //       }),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class FavoriteScreen extends StatelessWidget {
//   final FavoriteController favoriteController = Get.put(FavoriteController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text('Liked Fields', style: TextStyle(color: Colors.green)),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.green),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: Obx(() {
//         if (favoriteController.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (favoriteController.likedFields.isEmpty) {
//           return const Center(child: Text('No liked fields yet', style: TextStyle(color: Colors.white)));
//         }
//         return ListView.builder(
//           itemCount: favoriteController.likedFields.length,
//           itemBuilder: (context, index) {
//             final field = favoriteController.likedFields[index];
//             return ListTile(
//               leading: Image.network(field.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
//               title: Text(field.turfName, style: const TextStyle(color: Colors.white)),
//               subtitle: Text(field.location, style: const TextStyle(color: Colors.white)),
//               trailing: IconButton(
//                 icon: const Icon(Icons.favorite, color: Colors.red),
//                 onPressed: () => favoriteController.toggleLike(field),
//               ),
//               onTap: () {
//                 Get.to(() => DetailsPage(sportsField: field));
//               },
//             );
//           },
//         );
//       }),
//     );
//   }
// }

// class FavoriteController extends GetxController {
//   var likedFields = <SportsField>[].obs;
//   var isLoading = true.obs;
//   final String userPhoneNumber = '8374013715';

//   @override
//   void onInit() {
//     super.onInit();
//     fetchLikedFields();
//   }

//   Future<void> fetchLikedFields() async {
//     try {
//       final response = await http.get(Uri.parse('http://65.1.5.180:3000/users/favs/$userPhoneNumber'));
//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);
//         likedFields.value = data.map((json) => SportsField.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load liked fields');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void toggleLike(SportsField field) {
//     if (likedFields.contains(field)) {
//       likedFields.remove(field);
//     } else {
//       likedFields.add(field);
//     }
//     // Optionally, update the server with the new liked fields
//   }
// }

// class SportsField {
//   final String id;
//   final String imageUrl;
//   final String turfName;
//   final String location;

//   SportsField({
//     required this.id,
//     required this.imageUrl,
//     required this.turfName,
//     required this.location,
//   });

//   factory SportsField.fromJson(Map<String, dynamic> json) {
//     return SportsField(
//       id: json['_id'],
//       imageUrl: json['images'],
//       turfName: json['turfname'],
//       location: json['location'],
//     );
//   }
// }

// class DetailsPage extends StatelessWidget {
//   final SportsField sportsField;

//   const DetailsPage({Key? key, required this.sportsField}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(sportsField.turfName),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Image.network(sportsField.imageUrl),
//             Text(sportsField.turfName),
//             Text(sportsField.location),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<dynamic> favoriteTurfs = [];

  @override
  void initState() {
    super.initState();
    fetchFavoriteTurfs();
  }

  Future<void> fetchFavoriteTurfs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phoneNumber = prefs.getString('phoneNumber') ?? '';

    if (phoneNumber.isNotEmpty) {
      final url = 'http://65.1.5.180:3000/users/favs/$phoneNumber';
      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          setState(() {
            favoriteTurfs = data;
          });
        } else {
          print('Failed to load data: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching data: $e');
      }
    } else {
      print('Phone number not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favourite Turfs'),
          backgroundColor: Colors.green,
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: favoriteTurfs.isEmpty
              ? const Center(
                  child: Text(
                    'No favourites found.',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: favoriteTurfs.length,
                  itemBuilder: (context, index) {
                    final turf = favoriteTurfs[index];
                    return TurfCard(
                      turfName: turf['turfname'],
                      location: turf['location'],
                      imageUrl: turf['images'],
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class TurfCard extends StatelessWidget {
  final String turfName;
  final String location;
  final String imageUrl;

  const TurfCard({
    super.key,
    required this.turfName,
    required this.location,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  turfName,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  location,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
