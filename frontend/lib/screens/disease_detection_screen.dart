import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});

  @override
  State<DiseaseDetectionScreen> createState() =>
      _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState
    extends State<DiseaseDetectionScreen> {

  final supabase = Supabase.instance.client;
  final String groqApiKey = dotenv.env['GROQ_API_KEY'] ?? '';
  final TextEditingController cropController = TextEditingController();
  final TextEditingController symptomController = TextEditingController();

  String result = "";
  String solution = "";
  bool isLoading = false;

  Future<void> detectDisease() async {
    if (cropController.text.trim().isEmpty ||
        symptomController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter crop name and symptoms!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      String crop    = cropController.text.trim();
      String symptom = symptomController.text.trim();

      final url = Uri.parse('https://api.groq.com/openai/v1/chat/completions');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $groqApiKey',
        },
        body: jsonEncode({
          'model': 'llama-3.3-70b-versatile',
          'messages': [
            {
              'role': 'system',
              'content': 'You are an expert agricultural disease detection system for Indian farmers. '
                  'Based on crop name and symptoms, identify the disease and provide solution. '
                  'IMPORTANT: Detect the language of user input and reply in SAME language. '
                  'English input → English reply. Telugu input → Telugu reply. Tenglish → Tenglish. '
                  'Always respond in EXACTLY this format (no extra text before or after):\n'
                  'Disease: [disease name only]\n'
                  'Solution: [practical solution in 2-3 steps]',
            },
            {
              'role': 'user',
              'content': 'Crop: $crop\nSymptoms: $symptom\nDetect the disease and provide solution.'
            }
          ],
          'max_tokens': 300,
          'temperature': 0.5,
        }),
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception('API Error: ${jsonData['error']['message']}');
      }

      String aiResult = jsonData['choices'][0]['message']['content'];
      print('AI Result: $aiResult'); // Debug

      // ✅ Fixed Parse Logic
      List<String> parts = aiResult.split('\n');
      String detectedDisease  = '';
      String detectedSolution = '';
      bool solutionStarted    = false;

      for (String part in parts) {
        String trimmed = part.trim();
        if (trimmed.isEmpty) continue;

        if (trimmed.toLowerCase().startsWith('disease:')) {
          detectedDisease  = trimmed.replaceFirst(RegExp(r'disease:\s*', caseSensitive: false), '').trim();
          solutionStarted  = false;
        } else if (trimmed.toLowerCase().startsWith('solution:')) {
          detectedSolution = trimmed.replaceFirst(RegExp(r'solution:\s*', caseSensitive: false), '').trim();
          solutionStarted  = true;
        } else if (solutionStarted) {
          // Multi-line solution capture cheyyi
          detectedSolution += '\n$trimmed';
        }
      }

      // If parse kaakpothe full result show cheyyi
      if (detectedDisease.isEmpty) {
        detectedDisease  = aiResult;
        detectedSolution = '';
      }

      // ✅ Supabase lo Save Cheyyi
      await supabase.from('disease_detections').insert({
        'user_id'  : supabase.auth.currentUser!.id,
        'crop_name': crop,
        'symptoms' : symptom,
        'disease'  : detectedDisease,
        'solution' : detectedSolution,
      });

      setState(() {
        result    = detectedDisease;
        solution  = detectedSolution;
        isLoading = false;
      });

    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Disease Detection 🌿"),
        backgroundColor: Colors.green,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: cropController,
              decoration: const InputDecoration(
                labelText: "Crop Name (e.g. Rice, Wheat)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.grass, color: Colors.green),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: symptomController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Enter Symptoms (e.g. yellow leaves, brown spots)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.sick, color: Colors.orange),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : detectDisease,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(15),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Detect Disease 🔍",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 30),

            // ✅ Disease Result Card
            if (result.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "🦠 Detected Disease:",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      result,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),

                    if (solution.isNotEmpty) ...[
                      const SizedBox(height: 15),
                      const Divider(),
                      const SizedBox(height: 10),
                      const Text(
                        "✅ Solution:",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        solution,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}