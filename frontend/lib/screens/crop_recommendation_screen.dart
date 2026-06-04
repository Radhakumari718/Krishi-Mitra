import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CropRecommendationScreen extends StatefulWidget {
  const CropRecommendationScreen({super.key});

  @override
  State<CropRecommendationScreen> createState() =>
      _CropRecommendationScreenState();
}

class _CropRecommendationScreenState
    extends State<CropRecommendationScreen> {

  final TextEditingController nController =
      TextEditingController();

  final TextEditingController pController =
      TextEditingController();

  final TextEditingController kController =
      TextEditingController();

  final TextEditingController temperatureController =
      TextEditingController();

  final TextEditingController humidityController =
      TextEditingController();

  final TextEditingController phController =
      TextEditingController();

  final TextEditingController rainfallController =
      TextEditingController();

  String result = "";

  Future<void> recommendCrop() async {

    double n =
        double.tryParse(nController.text) ?? 0;

    double p =
        double.tryParse(pController.text) ?? 0;

    double k =
        double.tryParse(kController.text) ?? 0;

    double temperature =
        double.tryParse(
            temperatureController.text) ??
            0;

    double humidity =
        double.tryParse(
            humidityController.text) ??
            0;

    double ph =
        double.tryParse(phController.text) ?? 0;

    double rainfall =
        double.tryParse(
            rainfallController.text) ??
            0;

    String crop =
        await ApiService.recommendCrop(
      n,
      p,
      k,
      temperature,
      humidity,
      ph,
      rainfall,
    );

    setState(() {
      result =
          "Recommended Crop:\n\n$crop";
    });
  }

  Widget buildTextField(
      TextEditingController controller,
      String label) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType:
            TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border:
              const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text("AI Crop Recommendation"),
        backgroundColor: Colors.green,
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            buildTextField(
                nController,
                "Nitrogen (N)"),

            buildTextField(
                pController,
                "Phosphorus (P)"),

            buildTextField(
                kController,
                "Potassium (K)"),

            buildTextField(
                temperatureController,
                "Temperature"),

            buildTextField(
                humidityController,
                "Humidity"),

            buildTextField(
                phController,
                "pH"),

            buildTextField(
                rainfallController,
                "Rainfall"),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed:
                    recommendCrop,

                child: const Text(
                  "Recommend Crop",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              result,
              textAlign:
                  TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
                color:
                    Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}