import 'package:flutter/material.dart';

class CropRecommendationScreen
    extends StatefulWidget {

  const CropRecommendationScreen({
    super.key,
  });

  @override
  State<CropRecommendationScreen>
      createState() =>
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

    String soil =
        soilController.text.toLowerCase();

    String season =
        seasonController.text.toLowerCase();

    String water =
        waterController.text.toLowerCase();

    if (soil.contains("black") &&
        season.contains("winter")) {

      result =
          "Recommended Crop:\nWheat 🌾";

    } else if (soil.contains("red") &&
        water.contains("high")) {

      result =
          "Recommended Crop:\nRice 🌱";

    } else if (soil.contains("alluvial")) {

      result =
          "Recommended Crop:\nSugarcane 🌾";

    } else {

      result =
          "Recommended Crop:\nMillets 🌿";
    }

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text("Crop Recommendation"),
        backgroundColor: Colors.green,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: soilController,

              decoration: const InputDecoration(
                labelText: "Enter Soil Type",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: seasonController,

              decoration: const InputDecoration(
                labelText: "Enter Season",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: waterController,

              decoration: const InputDecoration(
                labelText:
                    "Water Availability",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                onPressed: recommendCrop,

                child: const Text(
                  "Recommend Crop",

                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 35),

            Text(
              result,

              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 24,
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