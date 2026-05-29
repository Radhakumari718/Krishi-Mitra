import 'package:flutter/material.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, String>> products = [

      {
        "name": "Rice",
        "price": "₹2500 / Quintal",
      },

      {
        "name": "Wheat",
        "price": "₹2200 / Quintal",
      },

      {
        "name": "Tomatoes",
        "price": "₹40 / Kg",
      },

      {
        "name": "Organic Fertilizer",
        "price": "₹800 / Bag",
      },

      {
        "name": "Pesticide Spray",
        "price": "₹600 / Bottle",
      },

      {
        "name": "Tractor Rental",
        "price": "₹1500 / Day",
      },

    ];

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

            return Card(

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

                      product["name"]!,

                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(

                      product["price"]!,

                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
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
            );
          },
        ),
      ),
    );
  }
}
