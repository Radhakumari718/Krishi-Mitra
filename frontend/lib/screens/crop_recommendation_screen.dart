import 'package:flutter/material.dart';

class CropRecommendationScreen extends StatefulWidget {
  const CropRecommendationScreen({super.key});

  @override
  State<CropRecommendationScreen> createState() =>
      _CropRecommendationScreenState();
}

class _CropRecommendationScreenState
    extends State<CropRecommendationScreen> {

  final TextEditingController soilController =
      TextEditingController();

  final TextEditingController seasonController =
      TextEditingController();

  final TextEditingController waterController =
      TextEditingController();

  String result = "";

  void recommendCrop() {

    String soil = soilController.text.toLowerCase();
    String season = seasonController.text.toLowerCase();
    String water = waterController.text.toLowerCase();

    if (soil == "black" &&
        season == "winter" &&
        water == "high") {

      result = "Recommended Crop: Wheat";

    } else if (soil == "red" &&
        season == "summer") {

      result = "Recommended Crop: Groundnut";

    } else {

      result = "Recommended Crop: Rice";
    }

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Crop Recommendation"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: soilController,

              decoration: const InputDecoration(
                labelText: "Soil Type",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: seasonController,

              decoration: const InputDecoration(
                labelText: "Season",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: waterController,

              decoration: const InputDecoration(
                labelText: "Water Availability",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: recommendCrop,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(15),
                ),

                child: const Text(
                  "Recommend Crop",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              result,

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