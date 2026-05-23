import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  File? selectedImage;

  String result = "";
  String solution = "";

  Future<void> pickImage() async {

    final pickedFile =
        await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {

      setState(() {

        selectedImage = File(pickedFile.path);

      });
    }
  }

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

      body: SingleChildScrollView(

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

            const SizedBox(height: 20),

            selectedImage != null

                ? ClipRRect(
                    borderRadius:
                        BorderRadius.circular(12),

                    child: Image.file(
                      selectedImage!,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )

                : Container(
                    height: 220,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(12),

                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),

                    child: const Center(
                      child: Text(
                        "No Image Selected",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(

                onPressed: pickImage,

                icon: const Icon(Icons.image),

                label: const Text(
                  "Upload Crop Image",
                ),
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

            Text(
              result,

              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              solution,
              textAlign: TextAlign.center,

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