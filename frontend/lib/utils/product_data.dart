import 'package:supabase_flutter/supabase_flutter.dart';

class ProductData {
  static final supabase = Supabase.instance.client;

  static List<Map<String, dynamic>> products = [];

  // Fetch products from Supabase
  static Future<void> fetchProducts() async {
    final response = await supabase
        .from('products')
        .select()
        .order('created_at', ascending: false);

    products = List<Map<String, dynamic>>.from(response);
  }

  // Add a new product to Supabase
  static Future<void> addProduct(Map<String, dynamic> product) async {
    await supabase.from('products').insert(product);
    await fetchProducts(); // refresh local list after adding
  }

  static void loadProducts(List<Map<String, dynamic>> savedProducts) {
    if (savedProducts.isNotEmpty) {
      products = savedProducts;
    }
  }
}