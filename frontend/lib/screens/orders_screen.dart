import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {'name': 'Tomatoes', 'status': 'Pending delivery', 'icon': Icons.schedule, 'color': const Color(0xFFf0a500), 'date': 'Today'},
      {'name': 'Rice', 'status': 'On the way', 'icon': Icons.local_shipping_outlined, 'color': const Color(0xFF1976D2), 'date': 'Yesterday'},
      {'name': 'Potatoes', 'status': 'Delivered', 'icon': Icons.check_circle_outline, 'color': const Color(0xFF1a6b2e), 'date': '3 days ago'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: orders.length,
        itemBuilder: (context, i) {
          final o = orders[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
            child: Row(children: [
              Container(
                width: 46, height: 46,
                decoration: BoxDecoration(color: (o['color'] as Color).withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                child: Icon(o['icon'] as IconData, color: o['color'] as Color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(o['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 3),
                    Text(o['status'] as String, style: TextStyle(fontSize: 13, color: o['color'] as Color, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Text(o['date'] as String, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ]),
          );
        },
      ),
    );
  }
}
