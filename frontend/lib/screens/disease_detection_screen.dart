import 'package:flutter/material.dart';

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

  final TextEditingController symptomController =
      TextEditingController();

  String result = "";
  String solution = "";

  void detectDisease() {

    String symptom =
        symptomController.text.toLowerCase();

    if (symptom.contains("yellow")) {

      result = "Detected Disease: Leaf Blight";

      solution =
          "Solution: Use organic pesticide spray";

    } else if (symptom.contains("spots")) {

      result = "Detected Disease: Fungal Infection";

      solution =
          "Solution: Apply fungicide treatment";

    } else {

      result = "Disease Not Clearly Identified";

      solution =
          "Solution: Consult agriculture expert";
    }

    setState(() {

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

            TextField(
              controller: cropController,

              decoration: const InputDecoration(
                labelText: "Crop Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: symptomController,

              decoration: const InputDecoration(
                labelText: "Enter Symptoms",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: detectDisease,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(15),
                ),

                child: const Text(
                  "Detect Disease",
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
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              solution,

              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),

          ],
        ),
      ),
    );
  }
}