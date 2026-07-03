import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tips = [
      {'title': 'Water management', 'tip': 'Irrigate crops early morning to reduce evaporation.', 'icon': '💧'},
      {'title': 'Organic farming', 'tip': 'Use compost and natural fertilizers for healthy soil.', 'icon': '🌱'},
      {'title': 'Pest control', 'tip': 'Inspect crops regularly for pest attacks.', 'icon': '🐛'},
      {'title': 'Weather alert', 'tip': 'Avoid spraying pesticides during rainy weather.', 'icon': '🌧️'},
      {'title': 'Crop rotation', 'tip': 'Rotate crops to maintain soil nutrients.', 'icon': '🔄'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('Farming Tips'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          final item = tips[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 42, height: 42,
                decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(10)),
                child: Center(child: Text(item['icon']!, style: const TextStyle(fontSize: 20))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(item['tip']!, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  ],
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
