import 'package:flutter/material.dart';
import '../utils/product_data.dart';
import 'product_details_screen.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final products = ProductData.products;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Marketplace"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: GridView.builder(

          itemCount: products.length,

          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.9,
          ),

          itemBuilder: (context, index) {

            final product = products[index];

            return InkWell(

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) => ProductDetailsScreen(

                      name: product["name"] ?? "",

                      price: product["price"] ?? "",

                      farmer: product["farmer"] ?? "Farmer",

                      location: product["location"] ?? "",

                      quantity: product["quantity"] ?? "",
                    ),
                  ),
                );
              },

              child: Card(

                elevation: 5,

                child: Padding(
                  padding: const EdgeInsets.all(15),

                  child: Column(

                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      const Icon(
                        Icons.shopping_bag,
                        size: 60,
                        color: Colors.green,
                      ),

                      const SizedBox(height: 15),

                      Text(

                        product["name"] ?? "",

                        textAlign: TextAlign.center,

                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(

                        product["price"] ?? "",

                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(

                        product["quantity"] ?? "",

                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      SizedBox(

                        width: double.infinity,

                        child: ElevatedButton(

                          onPressed: () {

                            ScaffoldMessenger.of(context)
                                .showSnackBar(

                              SnackBar(

                                content: Text(
                                  "${product["name"]} added to cart",
                                ),
                              ),
                            );
                          },

                          child: const Text("Buy"),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}