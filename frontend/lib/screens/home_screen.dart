import 'package:flutter/material.dart';

import 'product_details_screen.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final List<Map<String, String>>
        products = [

      {
        "name": "Tomatoes",
        "price": "₹40/Kg",
        "farmer": "Ramesh",
        "location": "Guntur",
      },

      {
        "name": "Rice",
        "price": "₹2800/Quintal",
        "farmer": "Suresh",
        "location": "Vijayawada",
      },

      {
        "name": "Potatoes",
        "price": "₹30/Kg",
        "farmer": "Mahesh",
        "location": "Kurnool",
      },

      {
        "name": "Onions",
        "price": "₹25/Kg",
        "farmer": "Naresh",
        "location": "Anantapur",
      },

    ];

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.green,

        title: const Text(
          "Krishi Mithra",
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(

              decoration:
                  InputDecoration(

                hintText:
                    "Search Products",

                prefixIcon:
                    const Icon(Icons.search),

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(
                    15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(

              child: GridView.builder(

                itemCount:
                    products.length,

                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.72,
                ),

                itemBuilder:
                    (context, index) {

                  final product =
                      products[index];

                  return GestureDetector(

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (context) =>
                              ProductDetailsScreen(

                            name:
                                product["name"]!,

                            price:
                                product["price"]!,

                            farmer:
                                product["farmer"]!,

                            location:
                                product["location"]!,
                          ),
                        ),
                      );
                    },

                    child: Card(

                      elevation: 5,

                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(
                          15,
                        ),
                      ),

                      child: Padding(
                        padding:
                            const EdgeInsets.all(
                          12,
                        ),

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Container(

                              height: 100,
                              width:
                                  double.infinity,

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.green.shade100,

                                borderRadius:
                                    BorderRadius.circular(
                                  12,
                                ),
                              ),

                              child: const Icon(
                                Icons.agriculture,
                                size: 60,
                                color:
                                    Colors.green,
                              ),
                            ),

                            const SizedBox(
                              height: 12,
                            ),

                            Text(
                              product["name"]!,

                              style:
                                  const TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 6,
                            ),

                            Text(
                              product["price"]!,

                              style:
                                  const TextStyle(
                                color:
                                    Colors.green,
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(
                              height: 6,
                            ),

                            Text(
                              "Farmer: ${product["farmer"]}",
                            ),

                            Text(
                              product["location"]!,
                            ),

                            const Spacer(),

                            SizedBox(
                              width:
                                  double.infinity,

                              child:
                                  ElevatedButton(

                                onPressed: () {

                                  ScaffoldMessenger.of(
                                          context)
                                      .showSnackBar(

                                    SnackBar(

                                      content: Text(
                                        "${product["name"]} added to cart 🛒",
                                      ),
                                    ),
                                  );
                                },

                                child: const Text(
                                  "Buy Now",
                                ),
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

          ],
        ),
      ),
    );
  }
}