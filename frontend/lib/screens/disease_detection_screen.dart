import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});
  @override
  State<DiseaseDetectionScreen> createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  XFile? selectedImage;
  Uint8List? imageBytes;
  String result = '';
  bool isLoading = false;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageBytes = await image.readAsBytes();
      setState(() => selectedImage = image);
    }
  }

  Future<void> detectDisease() async {
    if (selectedImage == null || imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select an image first')));
      return;
    }
    setState(() => isLoading = true);
    try {
      final response = await ApiService.detectDisease(imageBytes!, selectedImage!.name);
      setState(() => result = response);
    } catch (e) {
      setState(() => result = 'Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('Disease Detection'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF1a6b2e), width: 1.5),
                ),
                child: imageBytes != null
                    ? ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.memory(imageBytes!, fit: BoxFit.cover, width: double.infinity))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.biotech_outlined, size: 50, color: Color(0xFF1a6b2e)),
                          SizedBox(height: 10),
                          Text('Tap to select a leaf image', style: TextStyle(color: Color(0xFF1a6b2e), fontWeight: FontWeight.w600)),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: isLoading ? null : detectDisease,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1a6b2e), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: isLoading
                    ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Detect disease', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
            if (result.isNotEmpty && !isLoading) ...[
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFF1a6b2e).withOpacity(0.3))),
                child: Column(children: [
                  const Icon(Icons.health_and_safety, color: Color(0xFF1a6b2e), size: 32),
                  const SizedBox(height: 10),
                  const Text('Detection result', style: TextStyle(fontSize: 13, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text(result, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1a6b2e))),
                ]),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
