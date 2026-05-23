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

class FarmerDashboard extends StatelessWidget {
  const FarmerDashboard({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Farmer Dashboard"),
        backgroundColor: Colors.green,

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
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Manage your farming smartly",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,

                children: [

                  GestureDetector(

                    onTap: () {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              const CropRecommendationScreen(),
                        ),
                      );

                    },

                    child: dashboardCard(
                      Icons.agriculture,
                      "Crop Recommendation",
                    ),
                  ),

                  GestureDetector(

                    onTap: () {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              const WeatherScreen(),
                        ),
                      );

                    },

                    child: dashboardCard(
                      Icons.cloud,
                      "Weather Alerts",
                    ),
                  ),

                  GestureDetector(

                    onTap: () {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              const MarketplaceScreen(),
                        ),
                      );

                    },

                    child: dashboardCard(
                      Icons.store,
                      "Marketplace",
                    ),
                  ),

                  GestureDetector(

                    onTap: () {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              const ChatbotScreen(),
                        ),
                      );

                    },

                    child: dashboardCard(
                      Icons.chat,
                      "AI Chatbot",
                    ),
                  ),

                  GestureDetector(

                    onTap: () {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              const PricePredictionScreen(),
                        ),
                      );

                    },

                    child: dashboardCard(
                      Icons.show_chart,
                      "Price Prediction",
                    ),
                  ),

                  GestureDetector(

                    onTap: () {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              const DiseaseDetectionScreen(),
                        ),
                      );

                    },

                    child: dashboardCard(
                      Icons.health_and_safety,
                      "Disease Detection",
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboardCard(
    IconData icon,
    String title,
  ) {

    return Card(
      elevation: 5,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Icon(
            icon,
            size: 50,
            color: Colors.green,
          ),

          const SizedBox(height: 10),

          Text(
            title,
            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}