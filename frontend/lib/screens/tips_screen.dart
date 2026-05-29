import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, String>> tips = [

      {
        "title": "Water Management",
        "tip":
            "Irrigate crops early morning to reduce evaporation.",
      },

      {
        "title": "Organic Farming",
        "tip":
            "Use compost and natural fertilizers for healthy soil.",
      },

      {
        "title": "Pest Control",
        "tip":
            "Inspect crops regularly for pest attacks.",
      },

      {
        "title": "Weather Alert",
        "tip":
            "Avoid spraying pesticides during rainy weather.",
      },

      {
        "title": "Crop Rotation",
        "tip":
            "Rotate crops to maintain soil nutrients.",
      },

    ];

    return Scaffold(

      appBar: AppBar(
        title: const Text("Farming Tips"),
        backgroundColor: Colors.green,
      ),

      body: ListView.builder(

        padding: const EdgeInsets.all(16),

        itemCount: tips.length,

        itemBuilder: (context, index) {

          final item = tips[index];

          return Card(

            margin: const EdgeInsets.only(bottom: 15),

            child: ListTile(

              leading: const CircleAvatar(
                backgroundColor: Colors.green,

                child: Icon(
                  Icons.tips_and_updates,
                  color: Colors.white,
                ),
              ),

              title: Text(
                item["title"]!,

                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),

                child: Text(
                  item["tip"]!,
                  style: const TextStyle(
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