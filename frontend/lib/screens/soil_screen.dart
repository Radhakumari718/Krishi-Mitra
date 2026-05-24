import 'package:flutter/material.dart';

class SoilScreen extends StatefulWidget {
  const SoilScreen({super.key});

  @override
  State<SoilScreen> createState() =>
      _SoilScreenState();
}

class _SoilScreenState
    extends State<SoilScreen> {

  final TextEditingController soilController =
      TextEditingController();

  String result = "";

  void checkSoil() {

    String soil =
        soilController.text.toLowerCase();

    if (soil.contains("black")) {

      result =
          "Suitable Crops:\nCotton, Wheat, Sunflower";

    } else if (soil.contains("red")) {

      result =
          "Suitable Crops:\nGroundnut, Millet, Pulses";

    } else if (soil.contains("alluvial")) {

      result =
          "Suitable Crops:\nRice, Sugarcane, Wheat";

    } else {

      result =
          "Please enter valid soil type";
    }

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Soil Information"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
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

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                onPressed: checkSoil,

                child: const Text(
                  "Check Suitable Crops",

                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

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