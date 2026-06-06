import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api_service.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});

  @override
  State<DiseaseDetectionScreen> createState() =>
      _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState
    extends State<DiseaseDetectionScreen> {

  XFile? selectedImage;

  Uint8List? imageBytes;

  String result = "";

  bool isLoading = false;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {

    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {

      imageBytes = await image.readAsBytes();

      setState(() {
        selectedImage = image;
      });
    }
  }

  Future<void> detectDisease() async {

    if (selectedImage == null || imageBytes == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please select an image first",
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      String response =
          await ApiService.detectDisease(
        imageBytes!,
        selectedImage!.name,
      );

      setState(() {
        result = response;
      });

    } catch (e) {

      setState(() {
        result = "Error: $e";
      });

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Disease Detection",
        ),
        backgroundColor: Colors.green,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const Icon(
              Icons.health_and_safety,
              size: 100,
              color: Colors.green,
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(

              onPressed: pickImage,

              icon: const Icon(Icons.image),

              label: const Text(
                "Select Leaf Image",
              ),
            ),

            const SizedBox(height: 20),

            if (imageBytes != null)

              Image.memory(
                imageBytes!,
                height: 250,
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

            const SizedBox(height: 20),

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