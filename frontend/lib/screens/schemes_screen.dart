import 'package:flutter/material.dart';

class SchemesScreen extends StatelessWidget {
  const SchemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final schemes = [
      {'title': 'PM-Kisan Scheme', 'description': 'Financial support for eligible farmers.'},
      {'title': 'Crop Insurance', 'description': 'Protection against crop loss due to disasters.'},
      {'title': 'Fertilizer Subsidy', 'description': 'Government support for fertilizer purchases.'},
      {'title': 'Agriculture Loan', 'description': 'Low-interest loans for farming activities.'},
      {'title': 'Solar Pump Subsidy', 'description': 'Subsidy for solar-powered irrigation pumps.'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('Government Schemes'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: schemes.length,
        itemBuilder: (context, index) {
          final scheme = schemes[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 42, height: 42,
                decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.account_balance_outlined, color: Color(0xFF1a6b2e), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(scheme['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(scheme['description']!, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
            ]),
          );
        },
      ),
    );
  }
}
