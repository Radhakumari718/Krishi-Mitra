import 'package:flutter/material.dart';

class SoilScreen extends StatefulWidget {
  const SoilScreen({super.key});
  @override
  State<SoilScreen> createState() => _SoilScreenState();
}

class _SoilScreenState extends State<SoilScreen> {
  final soilController = TextEditingController();
  String result = '';

  void checkSoil() {
    final soil = soilController.text.toLowerCase();
    if (soil.contains('black')) {
      result = 'Cotton, Wheat, Sunflower';
    } else if (soil.contains('red')) {
      result = 'Groundnut, Millet, Pulses';
    } else if (soil.contains('alluvial')) {
      result = 'Rice, Sugarcane, Wheat';
    } else if (soil.isEmpty) {
      result = '';
    } else {
      result = 'Please enter a valid soil type';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('Soil Information'),
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
                controller: soilController,
                onSubmitted: (_) => checkSoil(),
                decoration: InputDecoration(
                  hintText: 'Enter soil type (black, red, alluvial...)',
                  prefixIcon: const Icon(Icons.landscape_outlined, color: Color(0xFF1a6b2e)),
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
                onPressed: checkSoil,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1a6b2e), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('Check suitable crops', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
            if (result.isNotEmpty) ...[
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF1a6b2e).withOpacity(0.3))),
                child: Column(children: [
                  const Icon(Icons.agriculture, color: Color(0xFF1a6b2e), size: 32),
                  const SizedBox(height: 10),
                  const Text('Suitable crops', style: TextStyle(fontSize: 13, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text(result, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1a6b2e))),
                ]),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
