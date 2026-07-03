import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Container(
              width: 90, height: 90,
              decoration: BoxDecoration(color: const Color(0xFFE8F5E9), shape: BoxShape.circle),
              child: const Icon(Icons.support_agent, size: 48, color: Color(0xFF1a6b2e)),
            ),
          ),
          const SizedBox(height: 24),
          _supportCard(Icons.call_outlined, 'Farmer helpline', '+91 1800-123-456'),
          _supportCard(Icons.mail_outline, 'Email support', 'support@krishimithra.com'),
          _supportCard(Icons.location_on_outlined, 'Agriculture office', 'Nearest Mandal office'),
          _supportCard(Icons.question_answer_outlined, 'FAQ', 'Frequently asked questions'),
        ],
      ),
    );
  }

  Widget _supportCard(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
      child: Row(children: [
        Container(
          width: 42, height: 42,
          decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: const Color(0xFF1a6b2e), size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 3),
              Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.grey)),
            ],
          ),
        ),
      ]),
    );
  }
}
