import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {

  static const String apiKey =
      "af6ddf6fc76c54ee1543fceeb71a6112";

  static Future<Map<String, dynamic>?>
      getWeather(String city) async {

    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {

      return jsonDecode(
        response.body,
      );

    } else {

      return null;
    }
  }
}