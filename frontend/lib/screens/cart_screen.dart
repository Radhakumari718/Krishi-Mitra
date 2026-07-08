import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> cartItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  double _parsePrice(dynamic rawPrice) {
    if (rawPrice == null) return 0;
    final match = RegExp(r'[\d.]+').firstMatch(rawPrice.toString());
    return match != null ? double.tryParse(match.group(0)!) ?? 0 : 0;
  }

  Future<void> _loadCart() async {
    setState(() => isLoading = true);
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        setState(() {
          cartItems = [];
          isLoading = false;
        });
        return;
      }

      final response = await supabase
          .from('cart')
          .select('id, quantity, product_id, products(*)')
          .eq('user_id', userId);

      final items = List<Map<String, dynamic>>.from(response).map((row) {
        final product = row['products'] as Map<String, dynamic>? ?? {};
        return {
          'cart_id': row['id'],
          'qty': row['quantity'] ?? 1,
          'name': product['name'] ?? 'Unknown',
          'farmer': product['farmer'] ?? '',
          'location': product['location'] ?? '',
          'price': _parsePrice(product['price']),
        };
      }).toList();

      setState(() {
        cartItems = items;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Failed to load cart: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> _updateQty(Map<String, dynamic> item, int newQty) async {
    if (newQty < 1) return;
    setState(() => item['qty'] = newQty);
    try {
      await supabase.from('cart').update({'quantity': newQty}).eq('id', item['cart_id']);
    } catch (e) {
      debugPrint('Failed to update quantity: $e');
    }
  }

  Future<void> _removeItem(Map<String, dynamic> item) async {
    try {
      await supabase.from('cart').delete().eq('id', item['cart_id']);
      setState(() => cartItems.remove(item));
    } catch (e) {
      debugPrint('Failed to remove item: $e');
    }
  }

  double get subtotal => cartItems.fold(0, (sum, item) => sum + (item['price'] * item['qty']));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: Text('Your cart (${cartItems.length} items)'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartItems.isEmpty
              ? Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('🛒', style: TextStyle(fontSize: 60)),
                    const SizedBox(height: 12),
                    const Text('Your cart is empty', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ]),
                )
              : ListView(
                  padding: const EdgeInsets.all(14),
                  children: [
                    ...cartItems.map((item) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 64, height: 64,
                              decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(10)),
                              child: const Center(child: Text('🌿', style: TextStyle(fontSize: 32))),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                  const SizedBox(height: 2),
                                  Text('${item['farmer']} · ${item['location']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                  const SizedBox(height: 6),
                                  Text('₹${item['price']}', style: const TextStyle(color: Color(0xFF1a6b2e), fontWeight: FontWeight.w600, fontSize: 14)),
                                  const SizedBox(height: 6),
                                  Row(children: [
                                    _qtyBtn(Icons.remove, () => _updateQty(item, item['qty'] - 1)),
                                    Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Text('${item['qty']}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                                    _qtyBtn(Icons.add, () => _updateQty(item, item['qty'] + 1)),
                                    const SizedBox(width: 10),
                                    Text('= ₹${(item['price'] * item['qty']).toStringAsFixed(0)}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                  ]),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                              onPressed: () => _removeItem(item),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
                      child: Column(children: [
                        _summaryRow('Subtotal', '₹${subtotal.toStringAsFixed(0)}'),
                        _summaryRow('Delivery', 'Free', valueColor: const Color(0xFF1a6b2e)),
                        _summaryRow('Platform fee', '₹0 (no middleman)'),
                        const Divider(height: 20),
                        _summaryRow('Total', '₹${subtotal.toStringAsFixed(0)}', bold: true, valueColor: const Color(0xFF1a6b2e)),
                      ]),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(10)),
                      child: const Row(children: [
                        Icon(Icons.check_circle, color: Color(0xFF1a6b2e), size: 20),
                        SizedBox(width: 8),
                        Expanded(child: Text('You saved by buying directly from farmers!', style: TextStyle(fontSize: 12, color: Color(0xFF2d8a45)))),
                      ]),
                    ),
                  ],
                ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentScreen())),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFf0a500), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: Text('Proceed to checkout — ₹${subtotal.toStringAsFixed(0)}', style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
            ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26, height: 26,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
        child: Icon(icon, size: 14),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: TextStyle(fontSize: bold ? 15 : 13, color: bold ? Colors.black : Colors.grey, fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        Text(value, style: TextStyle(fontSize: bold ? 16 : 13, fontWeight: bold ? FontWeight.bold : FontWeight.w600, color: valueColor ?? Colors.black87)),
      ]),
    );
  }
}