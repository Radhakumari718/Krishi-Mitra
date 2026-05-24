import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Farmer Profile"),
        backgroundColor: Colors.green,
      ),

      body: SingleChildScrollView(

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

            const SizedBox(height: 20),

            buildProfileCard(
              Icons.person,
              "Farmer Name",
              "Ramesh Kumar",
            ),

            buildProfileCard(
              Icons.phone,
              "Mobile Number",
              "+91 9876543210",
            ),

            buildProfileCard(
              Icons.location_on,
              "Village",
              "Andhra Pradesh",
            ),

            buildProfileCard(
              Icons.agriculture,
              "Farming Type",
              "Organic Farming",
            ),

            buildProfileCard(
              Icons.landscape,
              "Land Area",
              "5 Acres",
            ),

          ],
        ),
      ),
    );
  }

  Widget buildProfileCard(
    IconData icon,
    String title,
    String value,
  ) {

    return Card(

      margin: const EdgeInsets.only(
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

        title: Text(
          title,

          style: const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),

        subtitle: Text(
          value,

          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}