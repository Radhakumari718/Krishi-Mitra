import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.green,
      ),

      body: ListView(

        children: [

          notificationCard(
            Icons.cloud,
            "Rain Alert",
            "Heavy rain expected tomorrow",
          ),

          notificationCard(
            Icons.currency_rupee,
            "Market Price Alert",
            "Rice price increased by 10%",
          ),

          notificationCard(
            Icons.agriculture,
            "Crop Suggestion",
            "Best season to grow wheat",
          ),

          notificationCard(
            Icons.warning,
            "Pest Warning",
            "Possible pest attack detected",
          ),

        ],
      ),
    );
  }

  Widget notificationCard(
    IconData icon,
    String title,
    String subtitle,
  ) {

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),

      child: ListTile(

        leading: Icon(
          icon,
          color: Colors.green,
          size: 35,
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(subtitle),
      ),
    );
  }
}