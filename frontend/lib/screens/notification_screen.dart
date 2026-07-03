import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {'title': 'Rain alert', 'message': 'Heavy rain expected tomorrow.', 'icon': Icons.cloud_outlined, 'color': const Color(0xFF1976D2)},
      {'title': 'Market update', 'message': 'Tomato prices increased today.', 'icon': Icons.show_chart, 'color': const Color(0xFF1a6b2e)},
      {'title': 'Disease warning', 'message': 'Leaf infection detected nearby.', 'icon': Icons.warning_amber_outlined, 'color': const Color(0xFFD32F2F)},
      {'title': 'Irrigation reminder', 'message': 'Water crops this evening.', 'icon': Icons.water_drop_outlined, 'color': const Color(0xFF0288D1)},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 42, height: 42,
                decoration: BoxDecoration(color: (item['color'] as Color).withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
                child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(item['message'] as String, style: const TextStyle(fontSize: 13, color: Colors.grey)),
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
