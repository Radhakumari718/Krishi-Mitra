import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() =>
      _CartScreenState();
}

class _CartScreenState
    extends State<CartScreen> {

  final List<Map<String, String>>
      cartItems = [

    {
      "name": "Tomatoes",
      "price": "₹40/Kg",
    },

    {
      "name": "Rice",
      "price": "₹2800/Quintal",
    },

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("My Cart"),
        backgroundColor: Colors.green,
      ),

      body: Column(

        children: [

          Expanded(

            child: ListView.builder(

              itemCount:
                  cartItems.length,

              itemBuilder:
                  (context, index) {

                final item =
                    cartItems[index];

                return Card(

                  margin:
                      const EdgeInsets.all(
                    10,
                  ),

                  child: ListTile(

                    leading: const Icon(
                      Icons.shopping_cart,
                      color: Colors.green,
                    ),

                    title: Text(
                      item["name"]!,
                    ),

                    subtitle: Text(
                      item["price"]!,
                    ),

                    trailing: IconButton(

                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),

                      onPressed: () {

                        setState(() {

                          cartItems.removeAt(
                            index,
                          );

                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          Container(

            padding:
                const EdgeInsets.all(
              20,
            ),

            width: double.infinity,

            child: ElevatedButton(

              onPressed: () {

                ScaffoldMessenger.of(
                        context)
                    .showSnackBar(

                  const SnackBar(

                    content: Text(
                      "Proceeding To Checkout 💳",
                    ),
                  ),
                );
              },

              child: const Text(
                "Checkout",
              ),
            ),
          ),

        ],
      ),
    );
  }
}