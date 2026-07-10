import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final supabase = Supabase.instance.client;
  bool isPlacingOrder = false;

  double _parsePrice(dynamic rawPrice) {
    if (rawPrice == null) return 0;
    final match = RegExp(r'[\d.]+').firstMatch(rawPrice.toString());
    return match != null ? double.tryParse(match.group(0)!) ?? 0 : 0;
  }

  Future<void> _placeOrder(BuildContext context, String method) async {
    setState(() => isPlacingOrder = true);

    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('Not logged in');

      // Fetch current cart items with product info
      final cartResponse = await supabase
          .from('cart')
          .select('quantity, products(*)')
          .eq('user_id', userId);

      final cartRows = List<Map<String, dynamic>>.from(cartResponse);

      if (cartRows.isEmpty) {
        throw Exception('Your cart is empty');
      }

      final items = cartRows.map((row) {
        final product = row['products'] as Map<String, dynamic>? ?? {};
        final price = _parsePrice(product['price']);
        final qty = row['quantity'] ?? 1;
        return {
          'name': product['name'],
          'price': price,
          'quantity': qty,
          'subtotal': price * qty,
        };
      }).toList();

      final total = items.fold<double>(0, (sum, item) => sum + (item['subtotal'] as double));

      // Save order
      await supabase.from('orders').insert({
        'user_id': userId,
        'items': items,
        'total': total,
        'status': 'pending',
      });

      // Clear the cart after order is placed
      await supabase.from('cart').delete().eq('user_id', userId);

      if (!mounted) return;
      _showSuccess(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order: $e')),
      );
    } finally {
      if (mounted) setState(() => isPlacingOrder = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: isPlacingOrder
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Choose payment method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _paymentOption(context, Icons.account_balance_outlined, 'UPI Payment', 'Google Pay / PhonePe / Paytm'),
                  _paymentOption(context, Icons.money_outlined, 'Cash on delivery', 'Pay when order arrives'),
                  _paymentOption(context, Icons.credit_card_outlined, 'Card payment', 'Credit or debit card'),
                ],
              ),
            ),
    );
  }

  Widget _paymentOption(BuildContext context, IconData icon, String title, String subtitle) {
    return GestureDetector(
      onTap: () => _placeOrder(context, title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
        child: Row(children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: const Color(0xFF1a6b2e)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ]),
      ),
    );
  }

  void _showSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Column(children: [
            Icon(Icons.check_circle, color: Color(0xFF1a6b2e), size: 48),
            SizedBox(height: 10),
            Text('Order placed!', style: TextStyle(fontSize: 18)),
          ]),
          content: const Text('Your payment was successful and the farmer has been notified.', textAlign: TextAlign.center),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1a6b2e), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                child: const Text('Done', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }
}