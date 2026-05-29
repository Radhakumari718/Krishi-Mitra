import 'package:flutter/material.dart';

class ProductDetailsScreen
    extends StatelessWidget {

  final String name;
  final String price;
  final String farmer;
  final String location;

  const ProductDetailsScreen({

    super.key,

    required this.name,
    required this.price,
    required this.farmer,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text("Product Details"),
        backgroundColor: Colors.green,
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Container(

              height: 250,
              width: double.infinity,

              decoration: BoxDecoration(

                color: Colors.green.shade100,

                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: const Icon(
                Icons.agriculture,
                size: 120,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              name,

              style: const TextStyle(
                fontSize: 30,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              price,

              style: const TextStyle(
                fontSize: 24,
                color: Colors.green,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            buildInfoCard(
              Icons.person,
              "Farmer",
              farmer,
            ),

            buildInfoCard(
              Icons.location_on,
              "Location",
              location,
            ),

            buildInfoCard(
              Icons.inventory,
              "Available Stock",
              "100 Kg",
            ),

            buildInfoCard(
              Icons.verified,
              "Quality",
              "Fresh Organic Product",
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                onPressed: () {

                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(

                    const SnackBar(

                      content: Text(
                        "Added to Cart 🛒",
                      ),
                    ),
                  );
                },

                child: const Text(
                  "Add To Cart",

                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                onPressed: () {

                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(

                    const SnackBar(

                      content: Text(
                        "Order Placed Successfully 🌾",
                      ),
                    ),
                  );
                },

                child: const Text(
                  "Buy Now",

                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildInfoCard(
    IconData icon,
    String title,
    String value,
  ) {

    return Card(

      margin:
          const EdgeInsets.only(
        bottom: 15,
      ),

      child: ListTile(

        leading: CircleAvatar(
          backgroundColor:
              Colors.green,

          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),

        title: Text(title),

        subtitle: Text(
          value,

          style: const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),
    );
  }
}