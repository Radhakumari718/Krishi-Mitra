class ProductData {

  static List<Map<String, dynamic>> products = [

    {
      "name": "Rice",
      "price": "₹2500 / Quintal",
      "location": "Vizag",
      "farmer": "Farmer",
      "quantity": "100 Kg",
      "imageBytes": null,
    },

    {
      "name": "Wheat",
      "price": "₹2200 / Quintal",
      "location": "Vizag",
      "farmer": "Farmer",
      "quantity": "80 Kg",
      "imageBytes": null,
    },

  ];

  static void loadProducts(
      List<Map<String, dynamic>> savedProducts) {

    if (savedProducts.isNotEmpty) {
      products = savedProducts;
    }
  }
}