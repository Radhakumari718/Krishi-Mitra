import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String name;
  final String price;
  final String farmer;
  final String location;
  final String quantity;
  final Uint8List? imageBytes;

  const ProductDetailsScreen({
    super.key,
    required this.name,
    required this.price,
    required this.farmer,
    required this.location,
    required this.quantity,
    this.imageBytes,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _qty = 1;
  bool _isFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: const Color(0xFF1a6b2e),
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.9),
                child: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 20), onPressed: () => Navigator.pop(context)),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  child: IconButton(
                    icon: Icon(_isFav ? Icons.favorite : Icons.favorite_border, color: Colors.red, size: 20),
                    onPressed: () => setState(() => _isFav = !_isFav),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: const Color(0xFFE8F5E9),
                child: widget.imageBytes != null
                    ? Image.memory(widget.imageBytes!, fit: BoxFit.cover)
                    : const Center(child: Text('🌿', style: TextStyle(fontSize: 110))),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(20)),
                    child: const Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.eco, size: 14, color: Color(0xFF1a6b2e)),
                      SizedBox(width: 4),
                      Text('Certified organic', style: TextStyle(fontSize: 12, color: Color(0xFF1a6b2e), fontWeight: FontWeight.w600)),
                    ]),
                  ),
                  const SizedBox(height: 12),
                  Row(children: [
                    Text(widget.price, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1a6b2e))),
                  ]),
                  const SizedBox(height: 6),
                  Row(children: List.generate(4, (i) => const Icon(Icons.star, size: 16, color: Color(0xFFf0a500)))
                    ..add(const Icon(Icons.star_half, size: 16, color: Color(0xFFf0a500)))
                    ..add(const SizedBox(width: 6))
                    ..add(const Text('(124 reviews)', style: TextStyle(fontSize: 13, color: Colors.grey)))),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)),
                    child: Row(children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: const Color(0xFFC8E6C9),
                        child: Text(widget.farmer.isNotEmpty ? widget.farmer[0].toUpperCase() : 'F', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1a6b2e), fontSize: 18)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.farmer, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            const SizedBox(height: 2),
                            Row(children: [
                              const Icon(Icons.location_on_outlined, size: 12, color: Colors.grey),
                              const SizedBox(width: 2),
                              Expanded(child: Text(widget.location, style: const TextStyle(fontSize: 12, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis)),
                            ]),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Chat with ${widget.farmer} — coming soon 💬'))),
                        icon: const Icon(Icons.message_outlined, size: 16, color: Colors.white),
                        label: const Text('Chat', style: TextStyle(color: Colors.white, fontSize: 13)),
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1a6b2e), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(12)),
                    child: Column(children: [
                      _detailRow('Available stock', widget.quantity),
                      const Divider(height: 1),
                      _detailRow('Delivery', 'Within 24 hrs', valueColor: const Color(0xFF1a6b2e)),
                      const Divider(height: 1),
                      _detailRow('Harvested', 'Today'),
                    ]),
                  ),
                  const SizedBox(height: 18),
                  const Text('Quantity', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Row(children: [
                    _qtyButton(Icons.remove, () => setState(() => _qty = _qty > 1 ? _qty - 1 : 1)),
                    Container(width: 50, alignment: Alignment.center, child: Text('$_qty kg', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                    _qtyButton(Icons.add, () => setState(() => _qty++)),
                  ]),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, -2))]),
        child: Row(children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${widget.name} ($_qty kg) added to cart 🛒')));
              },
              style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF1a6b2e), width: 2), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Text('Add to cart', style: TextStyle(color: Color(0xFF1a6b2e), fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFf0a500), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Text('Buy now', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _detailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: valueColor ?? Colors.black87)),
      ]),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38, height: 38,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, size: 18),
      ),
    );
  }
}
