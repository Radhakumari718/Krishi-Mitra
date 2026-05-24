import 'package:flutter/material.dart';

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

class FarmerDashboard extends StatelessWidget {
  const FarmerDashboard({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Krishi Mithra"),

        actions: [

          IconButton(
            icon: const Icon(Icons.language),

            onPressed: () {

              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) =>
                      const LanguageScreen(),
                ),
              );

            },
          ),

          IconButton(
            icon: const Icon(Icons.notifications),

            onPressed: () {

              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) =>
                      const NotificationScreen(),
                ),
              );

            },
          ),

          IconButton(
            icon: const Icon(Icons.person),

            onPressed: () {

              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) =>
                      const ProfileScreen(),
                ),
              );

            },
          ),

          IconButton(
            icon: const Icon(Icons.logout),

            onPressed: () {

              Navigator.pushReplacement(
                context,

                MaterialPageRoute(
                  builder: (context) =>
                      const LoginScreen(),
                ),
              );

            },
          ),

        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Welcome Farmer 👨‍🌾",

              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Smart Farming Assistant",

              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: GridView.count(

                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,

                children: [

                  dashboardItem(
                    context,
                    Icons.agriculture,
                    "Crop\nRecommendation",
                    const CropRecommendationScreen(),
                  ),

                  dashboardItem(
                    context,
                    Icons.cloud,
                    "Weather\nAlerts",
                    const WeatherScreen(),
                  ),

                  dashboardItem(
                    context,
                    Icons.store,
                    "Marketplace",
                    const MarketplaceScreen(),
                  ),

                  dashboardItem(
                    context,
                    Icons.chat,
                    "AI\nChatbot",
                    const ChatbotScreen(),
                  ),

                  dashboardItem(
                    context,
                    Icons.show_chart,
                    "Price\nPrediction",
                    const PricePredictionScreen(),
                  ),

                  dashboardItem(
                    context,
                    Icons.health_and_safety,
                    "Disease\nDetection",
                    const DiseaseDetectionScreen(),
                  ),

                  dashboardItem(
                    context,
                    Icons.lightbulb,
                    "Farming\nTips",
                    const TipsScreen(),
                  ),

                  dashboardItem(
                    context,
                    Icons.account_balance,
                    "Govt\nSchemes",
                    const SchemesScreen(),
                  ),

                  dashboardItem(
                    context,
                    Icons.landscape,
                    "Soil\nInformation",
                    const SoilScreen(),
                  ),

                  dashboardItem(
                    context,
                    Icons.support_agent,
                    "Help &\nSupport",
                    const HelpSupportScreen(),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboardItem(
    BuildContext context,
    IconData icon,
    String title,
    Widget screen,
  ) {

    return GestureDetector(

      onTap: () {

        Navigator.push(
          context,

          MaterialPageRoute(
            builder: (context) => screen,
          ),
        );

      },

      child: Card(

        child: Container(

          decoration: BoxDecoration(

            borderRadius:
                BorderRadius.circular(15),

            gradient: LinearGradient(

              colors: [
                Colors.green.shade400,
                Colors.green.shade700,
              ],

              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          child: Column(

            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),

              const SizedBox(height: 15),

              Text(
                title,

                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}