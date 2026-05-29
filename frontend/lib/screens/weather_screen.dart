import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {

  const WeatherScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Weather Forecast"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            Container(

              width: double.infinity,
              padding:
                  const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: Colors.green,

                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Column(

                children: [

                  const Icon(
                    Icons.cloud,
                    size: 80,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "28°C",

                    style: TextStyle(
                      fontSize: 40,
                      fontWeight:
                          FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Cloudy Weather",

                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white70,
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),

            buildWeatherCard(
              Icons.water_drop,
              "Humidity",
              "70%",
            ),

            buildWeatherCard(
              Icons.air,
              "Wind Speed",
              "12 km/h",
            ),

            buildWeatherCard(
              Icons.grain,
              "Rain Chance",
              "60%",
            ),

            buildWeatherCard(
              Icons.thermostat,
              "Feels Like",
              "30°C",
            ),

          ],
        ),
      ),
    );
  }

  Widget buildWeatherCard(
    IconData icon,
    String title,
    String value,
  ) {

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
            icon,
            color: Colors.white,
          ),
        ),

        title: Text(
          title,

          style: const TextStyle(
            fontWeight:
                FontWeight.bold,
            fontSize: 18,
          ),
        ),

        trailing: Text(
          value,

          style: const TextStyle(
            fontSize: 18,
            color: Colors.green,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),
    );
  }
}