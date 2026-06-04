import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  // Flutter Chrome
  static const String baseUrl = "http://127.0.0.1:8000";

  // --------------------------------
  // CHATBOT API
  // --------------------------------
  static Future<String> chat(String message) async {

    final url = Uri.parse("$baseUrl/chat");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
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

  // --------------------------------
  // AI CROP RECOMMENDATION API
  // --------------------------------
  static Future<String> recommendCrop(
    double n,
    double p,
    double k,
    double temperature,
    double humidity,
    double ph,
    double rainfall,
  ) async {

    final url = Uri.parse("$baseUrl/recommend-crop");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "N": n,
        "P": p,
        "K": k,
        "temperature": temperature,
        "humidity": humidity,
        "ph": ph,
        "rainfall": rainfall,
      }),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      return data["recommended_crop"];

    } else {

      return "Error in recommendation";
    }
  }

  // --------------------------------
  // DISEASE DETECTION API
  // --------------------------------
  static Future<String> detectDisease(
    String crop,
  ) async {

    final url = Uri.parse("$baseUrl/detect-disease");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "crop": crop,
      }),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      return "${data['disease']}\n\nSolution: ${data['solution']}";

    } else {

      return "Error detecting disease";
    }
  }

  // --------------------------------
  // PRICE PREDICTION API
  // --------------------------------
  static Future<String> predictPrice(
    String crop,
  ) async {

    final url = Uri.parse("$baseUrl/predict-price");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "crop": crop,
      }),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      return data["predicted_price"];

    } else {

      return "Error predicting price";
    }
  }
}