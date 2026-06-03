import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ⚠️ IMPORTANT:
  // Replace with your backend IP
  // If running locally use: http://10.0.2.2:8000 (Android emulator)
  // If mobile device: use your PC IP like http://192.168.x.x:8000

  static const String baseUrl = "http://10.0.2.2:8000";

  // -------------------------
  // 1. Crop Recommendation
  // -------------------------
  static Future<String> recommendCrop(
      String soil, String season, String water) async {
    final url = Uri.parse("$baseUrl/recommend-crop");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "soil": soil,
        "season": season,
        "water": water,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["recommended_crop"];
    } else {
      return "Error in recommendation";
    }
  }

  // -------------------------
  // 2. Chatbot API
  // -------------------------
  static Future<String> chat(String message) async {
    final url = Uri.parse("$baseUrl/chat");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "message": message,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["reply"];
    } else {
      return "Error in chat response";
    }
  }

  // -------------------------
  // 3. Disease Detection (mock for now)
  // -------------------------
  static Future<String> detectDisease(String crop) async {
    final url = Uri.parse("$baseUrl/detect-disease");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "crop": crop,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return "${data['disease']} - ${data['solution']}";
    } else {
      return "Error detecting disease";
    }
  }
}