import 'package:flutter/material.dart';
import '../utils/favorites_data.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final favorites =
        FavoritesData.favoriteProducts;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Favorites ❤️"),
        backgroundColor: Colors.green,
      ),

      body: favorites.isEmpty

          ? const Center(
              child: Text(
                "No favorite products yet",
                style: TextStyle(fontSize: 18),
              ),
            )

          : ListView.builder(

              itemCount: favorites.length,

              itemBuilder: (context, index) {

                final product =
                    favorites[index];

                return Card(

                  margin:
                      const EdgeInsets.all(10),

                  child: ListTile(

                    leading: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),

                    title: Text(
                      product["name"] ?? "",
                    ),

                    subtitle: Text(
                      product["price"] ?? "",
                    ),
                  ),
                );
              },
            ),
    );
  }
}