import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() =>
      _WeatherScreenState();
}

class _WeatherScreenState
    extends State<WeatherScreen> {

  final TextEditingController cityController =
      TextEditingController();

  String temperature = "";
  String weather = "";
  String humidity = "";
  String windSpeed = "";

  bool isLoading = false;

  Future<void> getWeather() async {

    if (cityController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final data =
        await WeatherService.getWeather(
      cityController.text.trim(),
    );

    if (data != null) {

      setState(() {

        temperature =
            "${data['main']['temp']} °C";

        weather =
            data['weather'][0]['main'];

        humidity =
            "${data['main']['humidity']} %";

        windSpeed =
            "${data['wind']['speed']} m/s";

      });

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "City not found",
          ),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget buildCard(
    IconData icon,
    String title,
    String value,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Weather Forecast",
        ),
        backgroundColor: Colors.green,
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(

          child: Column(

            children: [

              TextField(

                controller: cityController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Enter City Name",
                  border:
                      OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed: getWeather,

                  child: const Text(
                    "Get Weather",
                  ),
                ),
              ),

              const SizedBox(height: 20),

              if (isLoading)
                const CircularProgressIndicator(),

              if (temperature.isNotEmpty)

                Column(

                  children: [

                    Text(
                      temperature,
                      style:
                          const TextStyle(
                        fontSize: 32,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    Text(
                      weather,
                      style:
                          const TextStyle(
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    buildCard(
                      Icons.water_drop,
                      "Humidity",
                      humidity,
                    ),

                    buildCard(
                      Icons.air,
                      "Wind Speed",
                      windSpeed,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}