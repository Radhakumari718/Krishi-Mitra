import 'package:flutter/material.dart';
import '../utils/product_data.dart';
import '../utils/favorites_data.dart';
import 'cart_screen.dart';
import 'product_details_screen.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});
  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  String _searchText = '';
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Vegetables', 'Grains', 'Fruits', 'Organic', 'Near me'];

  final List<Map<String, dynamic>> _deals = [
    {'name': 'Tomatoes', 'price': '₹35/kg', 'mrp': '₹50/kg', 'farmer': 'Ramesh, Guntur', 'emoji': '🍅', 'tag': '30% off', 'bg': const Color(0xFFFFF8E1)},
    {'name': 'Basmati Rice', 'price': '₹2,600/qt', 'mrp': '', 'farmer': 'Suresh, Vijayawada', 'emoji': '🌾', 'tag': 'Fresh stock', 'bg': const Color(0xFFE8F5E9)},
    {'name': 'Red Onions', 'price': '₹22/kg', 'mrp': '₹30/kg', 'farmer': 'Naresh, Anantapur', 'emoji': '🧅', 'tag': 'Bulk deal', 'bg': const Color(0xFFFCE4EC)},
    {'name': 'Potatoes', 'price': '₹28/kg', 'mrp': '₹35/kg', 'farmer': 'Mahesh, Kurnool', 'emoji': '🥔', 'tag': 'New', 'bg': const Color(0xFFE3F2FD)},
  ];

  @override
  Widget build(BuildContext context) {
    final products = ProductData.products.where((p) {
      final q = _searchText.toLowerCase();
      return (p['name'] ?? '').toLowerCase().contains(q) ||
          (p['farmer'] ?? '').toLowerCase().contains(q) ||
          (p['location'] ?? '').toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color(0xFF1a6b2e),
            title: Container(
              height: 38,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: TextField(
                onChanged: (v) => setState(() => _searchText = v),
                decoration: InputDecoration(
                  hintText: 'Search crops, farmers...',
                  hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            actions: [
              Stack(
                children: [
                  IconButton(icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()))),
                  Positioned(top: 8, right: 8, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFf0a500), shape: BoxShape.circle))),
                ],
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(36),
              child: Container(
                color: const Color(0xFF2d8a45),
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: _filters.map((f) {
                      final active = _selectedFilter == f;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedFilter = f),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                          decoration: BoxDecoration(
                            color: active ? Colors.white : Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(f, style: TextStyle(fontSize: 12, color: active ? const Color(0xFF1a6b2e) : Colors.white, fontWeight: active ? FontWeight.bold : FontWeight.normal)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(14, 16, 14, 10),
                  child: Text("Today's deals", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 168,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    itemCount: _deals.length,
                    itemBuilder: (_, i) {
                      final d = _deals[i];
                      return GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsScreen(
                          name: d['name'], price: d['price'], farmer: d['farmer'].split(',')[0].trim(),
                          location: d['farmer'].split(',').length > 1 ? d['farmer'].split(',')[1].trim() : '', quantity: '100 kg',
                        ))),
                        child: Container(
                          width: 130,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6)]),
                          child: Column(
                            children: [
                              Container(
                                height: 90,
                                decoration: BoxDecoration(color: d['bg'], borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
                                child: Center(child: Text(d['emoji'], style: const TextStyle(fontSize: 46))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(d['name'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                                    Text(d['price'], style: const TextStyle(fontSize: 13, color: Color(0xFF1a6b2e), fontWeight: FontWeight.w600)),
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(color: const Color(0xFFFFF3CD), borderRadius: BorderRadius.circular(4)),
                                      child: Text(d['tag'], style: const TextStyle(fontSize: 10, color: Color(0xFF856404))),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 16, 14, 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${products.length} products', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const Text('Sort: Relevance ▾', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            sliver: products.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(children: [
                          const Text('🌾', style: TextStyle(fontSize: 60)),
                          const SizedBox(height: 12),
                          const Text('No products found', style: TextStyle(fontSize: 16, color: Colors.grey)),
                        ]),
                      ),
                    ),
                  )
                : SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.72,
                    ),
                    delegate: SliverChildBuilderDelegate((_, i) => _productCard(context, products[i]), childCount: products.length),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _productCard(BuildContext context, Map<String, dynamic> product) {
    final isFav = FavoritesData.favoriteProducts.contains(product);
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsScreen(
        name: product['name'] ?? '',
        price: product['price'] ?? '',
        farmer: product['farmer'] ?? '',
        location: product['location'] ?? '',
        quantity: product['quantity'] ?? '',
        imageBytes: product['imageBytes'],
      ))),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 110,
                  width: double.infinity,
                  decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14))),
                  child: product['imageBytes'] != null
                      ? ClipRRect(borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)), child: Image.memory(product['imageBytes'], fit: BoxFit.cover))
                      : const Center(child: Text('🌿', style: TextStyle(fontSize: 48))),
                ),
                Positioned(
                  top: 8, right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isFav) FavoritesData.favoriteProducts.remove(product);
                        else FavoritesData.favoriteProducts.add(product);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isFav ? 'Removed from favourites' : '${product['name']} added to favourites ❤️'), duration: const Duration(seconds: 1)));
                    },
                    child: Container(
                      width: 30, height: 30,
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), shape: BoxShape.circle),
                      child: Icon(isFav ? Icons.favorite : Icons.favorite_border, size: 16, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product['name'] ?? '', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 3),
                  Text(product['price'] ?? '', style: const TextStyle(fontSize: 14, color: Color(0xFF1a6b2e), fontWeight: FontWeight.w700)),
                  const SizedBox(height: 3),
                  Row(children: [const Icon(Icons.person_outline, size: 12, color: Colors.grey), const SizedBox(width: 3), Expanded(child: Text(product['farmer'] ?? '', style: const TextStyle(fontSize: 11, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis))]),
                  Row(children: [const Icon(Icons.location_on_outlined, size: 12, color: Colors.grey), const SizedBox(width: 3), Expanded(child: Text(product['location'] ?? '', style: const TextStyle(fontSize: 11, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis))]),
                  const SizedBox(height: 4),
                  Row(children: [const Icon(Icons.star, size: 13, color: Color(0xFFf0a500)), const Icon(Icons.star, size: 13, color: Color(0xFFf0a500)), const Icon(Icons.star, size: 13, color: Color(0xFFf0a500)), const Icon(Icons.star, size: 13, color: Color(0xFFf0a500)), const Icon(Icons.star_half, size: 13, color: Color(0xFFf0a500)), const SizedBox(width: 4), const Text('(48)', style: TextStyle(fontSize: 11, color: Colors.grey))]),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 34,
                    child: ElevatedButton(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product['name']} added to cart 🛒'), duration: const Duration(seconds: 1))),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1a6b2e), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), padding: EdgeInsets.zero),
                      child: const Text('Add to cart', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
                    ),
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
