import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PricePredictionScreen extends StatefulWidget {
  const PricePredictionScreen({super.key});

  @override
  State<PricePredictionScreen> createState() =>
      _PricePredictionScreenState();
}

class _PricePredictionScreenState
    extends State<PricePredictionScreen> {

  final supabase = Supabase.instance.client;
  final String groqApiKey = dotenv.env['GROQ_API_KEY'] ?? '';
  final TextEditingController cropController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String result = "";
  bool isLoading = false;

  Future<void> predictPrice() async {
    if (cropController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter crop name and current price!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      String crop         = cropController.text.trim();
      String currentPrice = priceController.text.trim();

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
              // ✅ Fixed system prompt - auto language detection
              'content': 'You are an agricultural price prediction expert for Indian farmers. '
                  'Give realistic price predictions based on crop name and current market price. '
                  'IMPORTANT: Detect the language of the user question and reply reasons in SAME language. '
                  'If user types in English, give reasons in English. '
                  'If user types in Telugu, give reasons in Telugu. '
                  'If user types in Tenglish, give reasons in Tenglish. '
                  'Always respond in this exact format: Predicted Price: ₹XXXX. '
                  'Then give 2-3 short reasons in detected language.',
            },
            {
              'role': 'user',
              'content': 'Crop: $crop, Current Market Price: ₹$currentPrice per quintal. Predict the future price after 1 month.'
            }
          ],
          'max_tokens': 200,
          'temperature': 0.7,
        }),
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception('API Error: ${jsonData['error']['message']}');
      }

      String aiResult = jsonData['choices'][0]['message']['content'];

      await supabase.from('price_predictions').insert({
        'user_id'      : supabase.auth.currentUser!.id,
        'crop_name'    : crop,
        'current_price': double.tryParse(currentPrice) ?? 0.0,
        'prediction'   : aiResult,
      });

      setState(() {
        result    = aiResult;
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
        title: const Text("Price Prediction 📊"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
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
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Current Market Price (₹ per quintal)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.currency_rupee, color: Colors.green),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : predictPrice,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(15),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Predict Price 📊",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 30),

            if (result.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "🤖 AI Prediction:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      result,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}