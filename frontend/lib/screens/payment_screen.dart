import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: Padding(
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
      onTap: () => _showSuccess(context),
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
