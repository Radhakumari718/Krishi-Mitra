import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart';
import 'weather_screen.dart';
import 'marketplace_screen.dart';
import 'chatbot_screen.dart';
import 'crop_recommendation_screen.dart';
import 'profile_screen.dart';
import 'notification_screen.dart';
import 'language_screen.dart';
import 'price_prediction_screen.dart';
import 'disease_detection_screen.dart';
import 'tips_screen.dart';
import 'schemes_screen.dart';
import 'soil_screen.dart';
import 'help_support_screen.dart';
import 'sell_product_screen.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';

class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({super.key});

  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  final supabase = Supabase.instance.client;

  String _fullName = '';
  String _location = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;

      final data = await supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      setState(() {
        _fullName = data['full_name'] ?? 'Farmer';
        _location = data['location'] ?? '';
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Failed to load profile: $e');
      setState(() {
        _fullName = 'Farmer';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final initial = _fullName.isNotEmpty ? _fullName[0].toUpperCase() : 'F';

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: const Color(0xFF1a6b2e),
            actions: [
              IconButton(icon: const Icon(Icons.language, color: Colors.white), onPressed: () => _push(context, const LanguageScreen())),
              Stack(
                children: [
                  IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.white), onPressed: () => _push(context, const NotificationScreen())),
                  Positioned(top: 8, right: 8, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFf0a500), shape: BoxShape.circle))),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.logout_outlined, color: Colors.white),
                onPressed: () async {
                  await supabase.auth.signOut();
                  if (!mounted) return;
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(color: Color(0xFF1a6b2e)),
                padding: const EdgeInsets.fromLTRB(20, 90, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 46, height: 46,
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                          child: Center(child: Text(initial, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isLoading ? 'Good morning 👨‍🌾' : 'Good morning, $_fullName 👨‍🌾',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            const SizedBox(height: 2),
                            Text(_location, style: const TextStyle(fontSize: 12, color: Colors.white70)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  _statCard('₹12,400', 'This month', Icons.currency_rupee),
                  const SizedBox(width: 10),
                  _statCard('47', 'Total orders', Icons.receipt_long_outlined),
                  const SizedBox(width: 10),
                  _statCard('4.8★', 'Rating', Icons.star_outline),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () => _push(context, const SellProductScreen()),
              child: Container(
                margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  border: Border.all(color: const Color(0xFFf0a500)),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.add_circle_outline, color: Color(0xFF856404), size: 28),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('List a new product', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF856404), fontSize: 15)),
                        SizedBox(height: 2),
                        Text('Sell directly. Zero commission.', style: TextStyle(fontSize: 12, color: Color(0xFFa07800))),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(color: const Color(0xFFf0a500), borderRadius: BorderRadius.circular(8)),
                      child: const Text('Start', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
              child: const Text('Quick access', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.6,
              ),
              delegate: SliverChildListDelegate([
                _menuCard(context, Icons.agriculture_outlined, 'Crop advisor', 'AI recommendation', const Color(0xFFE8F5E9), const CropRecommendationScreen()),
                _menuCard(context, Icons.biotech_outlined, 'Disease check', 'Scan your crop', const Color(0xFFFCE4EC), const DiseaseDetectionScreen()),
                _menuCard(context, Icons.show_chart, 'Price tracker', 'Market rates', const Color(0xFFFFF8E1), const PricePredictionScreen()),
                _menuCard(context, Icons.cloud_outlined, 'Weather', '7-day forecast', const Color(0xFFE3F2FD), const WeatherScreen()),
                _menuCard(context, Icons.chat_bubble_outline, 'AI chatbot', 'Ask anything', const Color(0xFFF3E5F5), const ChatbotScreen()),
                _menuCard(context, Icons.account_balance_outlined, 'Govt schemes', 'Your benefits', const Color(0xFFE0F2F1), const SchemesScreen()),
                _menuCard(context, Icons.lightbulb_outline, 'Farming tips', 'Best practices', const Color(0xFFFBE9E7), const TipsScreen()),
                _menuCard(context, Icons.landscape_outlined, 'Soil info', 'Know your land', const Color(0xFFE8EAF6), const SoilScreen()),
                _menuCard(context, Icons.store_outlined, 'Marketplace', 'Browse & buy', const Color(0xFFE8F5E9), const MarketplaceScreen()),
                _menuCard(context, Icons.favorite_outline, 'Favourites', 'Saved items', const Color(0xFFFCE4EC), const FavoritesScreen()),
                _menuCard(context, Icons.shopping_cart_outlined, 'My cart', 'View cart', const Color(0xFFFFF8E1), const CartScreen()),
                _menuCard(context, Icons.support_agent_outlined, 'Help & support', 'Get assistance', const Color(0xFFF3E5F5), const HelpSupportScreen()),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _push(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  Widget _statCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: const Color(0xFF1a6b2e)),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1a6b2e))),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(BuildContext context, IconData icon, String title, String sub, Color bg, Widget screen) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
        ),
        child: Row(
          children: [
            Container(
              width: 42, height: 42,
              decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: const Color(0xFF1a6b2e), size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(sub, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}