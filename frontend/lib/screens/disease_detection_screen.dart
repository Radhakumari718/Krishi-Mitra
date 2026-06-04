import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});

  @override
  State<DiseaseDetectionScreen> createState() =>
      _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState
    extends State<DiseaseDetectionScreen> {

  final TextEditingController cropController =
      TextEditingController();

  String result = "";
  bool isLoading = false;

  Future<void> detectDisease() async {

    String crop = cropController.text.trim();

    if (crop.isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    String response =
        await ApiService.detectDisease(crop);

    setState(() {
      result = response;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Disease Detection"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const Icon(
              Icons.health_and_safety,
              size: 100,
              color: Colors.green,
            ),

            const SizedBox(height: 20),

            TextField(
              controller: cropController,

              decoration: const InputDecoration(
                labelText: "Enter Crop Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                onPressed: detectDisease,

                child: const Text(
                  "Detect Disease",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            if (isLoading)
              const CircularProgressIndicator(),

            if (!isLoading)
              Text(
                result,
                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }
}