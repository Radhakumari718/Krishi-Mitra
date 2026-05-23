import 'package:flutter/material.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Marketplace"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView(

          children: [

            cropCard(
              "Rice",
              "₹2500 / Quintal",
              Icons.grass,
            ),

            cropCard(
              "Tomato",
              "₹1200 / Quintal",
              Icons.eco,
            ),

            cropCard(
              "Wheat",
              "₹2200 / Quintal",
              Icons.agriculture,
            ),

          ],
        ),
      ),
    );
  }

  Widget cropCard(
    String cropName,
    String price,
    IconData icon,
  ) {

    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 20),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Row(

          children: [

            Icon(
              icon,
              size: 50,
              color: Colors.green,
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    cropName,

                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    price,

                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {

              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),

              child: const Text(
                "Buy",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}