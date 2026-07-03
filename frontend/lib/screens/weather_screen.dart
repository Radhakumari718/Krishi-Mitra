import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final cityController = TextEditingController();
  String temperature = '';
  String weather = '';
  String humidity = '';
  String windSpeed = '';
  bool isLoading = false;

  Future<void> getWeather() async {
    if (cityController.text.trim().isEmpty) return;
    setState(() => isLoading = true);
    final data = await WeatherService.getWeather(cityController.text.trim());
    if (data != null) {
      setState(() {
        temperature = '${data['main']['temp']}°';
        weather = data['weather'][0]['main'];
        humidity = '${data['main']['humidity']}%';
        windSpeed = '${data['wind']['speed']} m/s';
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('City not found')));
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('Weather Forecast'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
              child: TextField(
                controller: cityController,
                onSubmitted: (_) => getWeather(),
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                  prefixIcon: const Icon(Icons.location_city, color: Color(0xFF1a6b2e)),
                  suffixIcon: IconButton(icon: const Icon(Icons.search, color: Color(0xFF1a6b2e)), onPressed: getWeather),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (isLoading) const Padding(padding: EdgeInsets.all(30), child: CircularProgressIndicator(color: Color(0xFF1a6b2e))),
            if (temperature.isNotEmpty && !isLoading) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF1a6b2e), Color(0xFF2d8a45)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(children: [
                  Text(temperature, style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(weather, style: const TextStyle(fontSize: 18, color: Colors.white70)),
                  Text(cityController.text, style: const TextStyle(fontSize: 14, color: Colors.white60)),
                ]),
              ),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(child: _infoCard(Icons.water_drop_outlined, 'Humidity', humidity)),
                const SizedBox(width: 12),
                Expanded(child: _infoCard(Icons.air, 'Wind speed', windSpeed)),
              ]),
            ],
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
      child: Column(children: [
        Icon(icon, color: const Color(0xFF1a6b2e), size: 28),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ]),
    );
  }
}
