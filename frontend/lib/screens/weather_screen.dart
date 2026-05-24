import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
        backgroundColor: Colors.green,
      ),

      body: const Center(
        child: Text(
          "Weather Screen",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}