import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {

  static const String productsKey = "products";

  static Future<void> saveProducts(
      List<Map<String, dynamic>> products) async {

    final prefs =
        await SharedPreferences.getInstance();

    final jsonString =
        jsonEncode(products);

    await prefs.setString(
      productsKey,
      jsonString,
    );
  }

  static Future<List<Map<String, dynamic>>>
      loadProducts() async {

    final prefs =
        await SharedPreferences.getInstance();

    final jsonString =
        prefs.getString(productsKey);

    if (jsonString == null) {
      return [];
    }

    final List<dynamic> decoded =
        jsonDecode(jsonString);

    return decoded
        .map((e) =>
            Map<String, dynamic>.from(e))
        .toList();
  }
}