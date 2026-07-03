import 'package:flutter/material.dart';

class PricePredictionScreen extends StatefulWidget {
  const PricePredictionScreen({super.key});
  @override
  State<PricePredictionScreen> createState() => _PricePredictionScreenState();
}

class _PricePredictionScreenState extends State<PricePredictionScreen> {
  final cropController = TextEditingController();
  String result = '';
  String emoji = '';

  void predictPrice() {
    final crop = cropController.text.toLowerCase();
    if (crop.contains('rice')) {
      result = '₹2,800 / Quintal';
      emoji = '🌾';
    } else if (crop.contains('wheat')) {
      result = '₹2,400 / Quintal';
      emoji = '🌾';
    } else if (crop.contains('tomato')) {
      result = '₹50 / Kg';
      emoji = '🍅';
    } else if (crop.isEmpty) {
      result = '';
      emoji = '';
    } else {
      result = 'Price data unavailable';
      emoji = '❓';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('Price Prediction'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
              child: TextField(
                controller: cropController,
                onSubmitted: (_) => predictPrice(),
                decoration: InputDecoration(
                  hintText: 'Enter crop name (e.g. rice, wheat)',
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF1a6b2e)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: predictPrice,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1a6b2e), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('Predict price', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
            if (result.isNotEmpty) ...[
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFF1a6b2e).withOpacity(0.3))),
                child: Column(children: [
                  Text(emoji, style: const TextStyle(fontSize: 40)),
                  const SizedBox(height: 8),
                  const Text('Predicted price', style: TextStyle(fontSize: 13, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text(result, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1a6b2e))),
                ]),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
