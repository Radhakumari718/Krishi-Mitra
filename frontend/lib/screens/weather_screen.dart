import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Weather Alerts"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Today's Weather",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            weatherCard(
              Icons.wb_sunny,
              "Temperature",
              "32°C",
            ),

            const SizedBox(height: 20),

            weatherCard(
              Icons.water_drop,
              "Humidity",
              "70%",
            ),

            const SizedBox(height: 20),

            weatherCard(
              Icons.cloud,
              "Rain Alert",
              "Possible rain tomorrow",
            ),

          ],
        ),
      ),
    );
  }

  Widget weatherCard(
    IconData icon,
    String title,
    String value,
  ) {

    return Card(
      elevation: 5,

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Row(

          children: [

            Icon(
              icon,
              size: 40,
              color: Colors.green,
            ),

            const SizedBox(width: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  value,

                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}