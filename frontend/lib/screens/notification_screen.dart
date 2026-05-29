import 'package:flutter/material.dart';

class NotificationScreen
    extends StatelessWidget {

  const NotificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>>
        notifications = [

      {
        "title":
            "Rain Alert 🌧️",
        "message":
            "Heavy rain expected tomorrow.",
        "icon": Icons.cloud,
      },

      {
        "title":
            "Market Update 📈",
        "message":
            "Tomato prices increased today.",
        "icon": Icons.show_chart,
      },

      {
        "title":
            "Disease Warning 🚨",
        "message":
            "Leaf infection detected nearby.",
        "icon":
            Icons.health_and_safety,
      },

      {
        "title":
            "Irrigation Reminder 💧",
        "message":
            "Water crops this evening.",
        "icon": Icons.water_drop,
      },

    ];

    return Scaffold(

      appBar: AppBar(
        title:
            const Text("Notifications"),
        backgroundColor: Colors.green,
      ),

      body: ListView.builder(

        padding:
            const EdgeInsets.all(16),

        itemCount:
            notifications.length,

        itemBuilder: (context, index) {

          final item =
              notifications[index];

          return Card(

            margin:
                const EdgeInsets.only(
              bottom: 15,
            ),

            child: ListTile(

              leading: CircleAvatar(
                backgroundColor:
                    Colors.green,

                child: Icon(
                  item["icon"],
                  color: Colors.white,
                ),
              ),

              title: Text(
                item["title"],

                style: const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              subtitle: Padding(
                padding:
                    const EdgeInsets.only(
                  top: 8,
                ),

                child: Text(
                  item["message"],

                  style:
                      const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}