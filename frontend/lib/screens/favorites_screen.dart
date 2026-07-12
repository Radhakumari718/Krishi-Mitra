import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'product_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> favorites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() => isLoading = true);
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        setState(() {
          favorites = [];
          isLoading = false;
        });
        return;
      }

      final response = await supabase
          .from('favorites')
          .select('id, product_id, products(*)')
          .eq('user_id', userId);

      final items = List<Map<String, dynamic>>.from(response).map((row) {
        final product = row['products'] as Map<String, dynamic>? ?? {};
        return {
          'favorite_id': row['id'],
          'id': row['product_id'],
          'name': product['name'] ?? '',
          'price': product['price'] ?? '',
          'farmer': product['farmer'] ?? '',
          'location': product['location'] ?? '',
          'quantity': product['quantity'] ?? '',
        };
      }).toList();

      setState(() {
        favorites = items;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Failed to load favorites: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> _removeFavorite(Map<String, dynamic> item) async {
    try {
      await supabase.from('favorites').delete().eq('id', item['favorite_id']);
      setState(() => favorites.remove(item));
    } catch (e) {
      debugPrint('Failed to remove favorite: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('Favourites'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : favorites.isEmpty
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
                        location: product['location'] ?? '', quantity: product['quantity'] ?? '',
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
                            onPressed: () => _removeFavorite(product),
                          ),
                        ]),
                      ),
                    );
                  },
                ),
    );
  }
}