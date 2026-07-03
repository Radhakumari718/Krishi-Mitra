import 'package:flutter/material.dart';
import '../utils/favorites_data.dart';
import 'product_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesData.favoriteProducts;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('Favourites'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('❤️', style: TextStyle(fontSize: 60)),
                const SizedBox(height: 12),
                const Text('No favourite products yet', style: TextStyle(fontSize: 15, color: Colors.grey)),
              ]),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsScreen(
                    name: product['name'] ?? '', price: product['price'] ?? '', farmer: product['farmer'] ?? '',
                    location: product['location'] ?? '', quantity: product['quantity'] ?? '', imageBytes: product['imageBytes'],
                  ))),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
                    child: Row(children: [
                      Container(
                        width: 56, height: 56,
                        decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(10)),
                        child: const Center(child: Text('🌿', style: TextStyle(fontSize: 26))),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            const SizedBox(height: 3),
                            Text(product['price'] ?? '', style: const TextStyle(color: Color(0xFF1a6b2e), fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red, size: 20),
                        onPressed: () => setState(() => FavoritesData.favoriteProducts.removeAt(index)),
                      ),
                    ]),
                  ),
                );
              },
            ),
    );
  }
}
