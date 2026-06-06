import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final supabase = Supabase.instance.client;
  final String apiKey = '337f7497ebaddb5ac3834b7069e7fc18';

  String location    = "";
  double temperature = 0.0;
  double humidity    = 0.0;
  bool rainAlert     = false;
  String rainMessage = "";
  bool isLoading     = true;

  @override
  void initState() {
    super.initState();
    fetchAndSaveWeather();
  }

  // ✅ Step 1: Get GPS Location
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled. Please enable GPS.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied. Please enable in settings.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // ✅ Step 2: Fetch Weather using lat & lon
  Future<void> fetchAndSaveWeather() async {
    setState(() => isLoading = true);
    try {
      // Get current GPS position
      Position position = await getCurrentLocation();
      double lat = position.latitude;
      double lon = position.longitude;

      // Call OpenWeatherMap with lat & lon (your actual location!)
      final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'
      );
      final response = await http.get(url);
      final jsonData = jsonDecode(response.body);

      print('API Response: $jsonData');

      if (jsonData['cod'] != 200) {
        throw Exception('API Error: ${jsonData['message']}');
      }

      double temp    = (jsonData['main']['temp'] as num).toDouble();
      double hum     = (jsonData['main']['humidity'] as num).toDouble();
      String cityName = jsonData['name'].toString(); // ✅ Real city name from API
      String weather = jsonData['weather'][0]['main'].toString();
      bool rain      = weather == 'Rain' ||
                       weather == 'Drizzle' ||
                       weather == 'Thunderstorm';
      String message = rain ? 'Rain expected today! ☔' : 'No rain expected 🌤️';

      // Save to Supabase
      await supabase.from('weather_data').insert({
        'location'    : cityName,
        'temperature' : temp,
        'humidity'    : hum,
        'rain_alert'  : rain,
        'rain_message': message,
      });

      setState(() {
        location    = cityName;
        temperature = temp;
        humidity    = hum;
        rainAlert   = rain;
        rainMessage = message;
        isLoading   = false;
      });

    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Alerts"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchAndSaveWeather,
          ),
        ],
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.green),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "📍 $location",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  weatherCard(
                    Icons.wb_sunny,
                    "Temperature",
                    "${temperature.toStringAsFixed(1)}°C",
                    Colors.orange,
                  ),
                  const SizedBox(height: 20),

                  weatherCard(
                    Icons.water_drop,
                    "Humidity",
                    "${humidity.toStringAsFixed(1)}%",
                    Colors.blue,
                  ),
                  const SizedBox(height: 20),

                  weatherCard(
                    rainAlert ? Icons.thunderstorm : Icons.cloud,
                    "Rain Alert",
                    rainMessage,
                    rainAlert ? Colors.red : Colors.green,
                  ),

                ],
              ),
            ),
    );
  }

  Widget weatherCard(IconData icon, String title, String value, Color color) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, size: 40, color: color),
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