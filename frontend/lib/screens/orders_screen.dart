import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: Colors.green,
      ),

      body: ListView(
        children: const [

          ListTile(
            leading: Icon(
              Icons.pending,
              color: Colors.orange,
            ),
            title: Text("Tomatoes"),
            subtitle: Text("Pending Delivery"),
          ),

          Divider(),

          ListTile(
            leading: Icon(
              Icons.local_shipping,
              color: Colors.blue,
            ),
            title: Text("Rice"),
            subtitle: Text("On The Way"),
          ),

          Divider(),

          ListTile(
            leading: Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            title: Text("Potatoes"),
            subtitle: Text("Delivered"),
          ),
        ],
      ),
    );
  }
}