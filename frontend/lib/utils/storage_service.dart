import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {

  static const String productsKey = "products";

  static Future<void> saveProducts(
      List<Map<String, dynamic>> products) async {

    final prefs =
        await SharedPreferences.getInstance();

    final List<Map<String, dynamic>> serializableProducts = products.map((product) {
      final Map<String, dynamic> copy = Map.from(product);
      if (copy["imageBytes"] != null && copy["imageBytes"] is Uint8List) {
        copy["imageBytes"] = base64Encode(copy["imageBytes"] as Uint8List);
      }
      return copy;
    }).toList();

    final jsonString =
        jsonEncode(serializableProducts);

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
        .map((product) {
          if (product["imageBytes"] != null && product["imageBytes"] is String) {
            product["imageBytes"] = base64Decode(product["imageBytes"] as String);
          }
          return product;
        })
        .toList();
  }
}