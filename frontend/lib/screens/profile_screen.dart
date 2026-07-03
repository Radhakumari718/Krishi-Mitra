import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF1a6b2e),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: const Color(0xFF1a6b2e),
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Container(
                      width: 84, height: 84,
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                      child: const Center(child: Text('R', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white))),
                    ),
                    const SizedBox(height: 10),
                    const Text('Ramesh Kumar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    const Text('Verified farmer', style: TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _profileCard(Icons.phone_outlined, 'Mobile number', '+91 9876543210'),
                  _profileCard(Icons.location_on_outlined, 'Village', 'Guntur, Andhra Pradesh'),
                  _profileCard(Icons.agriculture_outlined, 'Farming type', 'Organic farming'),
                  _profileCard(Icons.landscape_outlined, 'Land area', '5 acres'),
                  _profileCard(Icons.star_outline, 'Rating', '4.8 ★ (124 reviews)'),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_outlined, color: Color(0xFF1a6b2e)),
                      label: const Text('Edit profile', style: TextStyle(color: Color(0xFF1a6b2e), fontWeight: FontWeight.w600)),
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF1a6b2e)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileCard(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
      child: Row(children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: const Color(0xFF1a6b2e), size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ]),
    );
  }
}
