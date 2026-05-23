import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Farmer Profile"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.green,

              child: Icon(
                Icons.person,
                size: 70,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 30),

            profileTile(
              Icons.person,
              "Farmer Name",
              "Ramu Farmer",
            ),

            profileTile(
              Icons.phone,
              "Phone Number",
              "+91 9876543210",
            ),

            profileTile(
              Icons.location_on,
              "Village",
              "Andhra Pradesh",
            ),

            profileTile(
              Icons.agriculture,
              "Farming Type",
              "Organic Farming",
            ),

          ],
        ),
      ),
    );
  }

  Widget profileTile(
    IconData icon,
    String title,
    String value,
  ) {

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),

      child: ListTile(

        leading: Icon(
          icon,
          color: Colors.green,
        ),

        title: Text(title),

        subtitle: Text(value),
      ),
    );
  }
}