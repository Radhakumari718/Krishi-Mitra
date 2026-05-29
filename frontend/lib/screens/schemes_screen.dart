import 'package:flutter/material.dart';

class SchemesScreen extends StatelessWidget {
  const SchemesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, String>> schemes = [

      {
        "title": "PM-Kisan Scheme",
        "description":
            "Financial support for eligible farmers.",
      },

      {
        "title": "Crop Insurance",
        "description":
            "Protection against crop loss due to disasters.",
      },

      {
        "title": "Fertilizer Subsidy",
        "description":
            "Government support for fertilizer purchases.",
      },

      {
        "title": "Agriculture Loan",
        "description":
            "Low-interest loans for farming activities.",
      },

      {
        "title": "Solar Pump Subsidy",
        "description":
            "Subsidy for solar-powered irrigation pumps.",
      },

    ];

    return Scaffold(

      appBar: AppBar(
        title: const Text("Government Schemes"),
        backgroundColor: Colors.green,
      ),

      body: ListView.builder(

        padding: const EdgeInsets.all(16),

        itemCount: schemes.length,

        itemBuilder: (context, index) {

          final scheme = schemes[index];

          return Card(

            margin: const EdgeInsets.only(bottom: 15),

            child: ListTile(

              leading: const CircleAvatar(
                backgroundColor: Colors.green,

                child: Icon(
                  Icons.account_balance,
                  color: Colors.white,
                ),
              ),

              title: Text(
                scheme["title"]!,

                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),

                child: Text(
                  scheme["description"]!,

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