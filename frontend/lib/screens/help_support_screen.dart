import 'package:flutter/material.dart';

class HelpSupportScreen
    extends StatelessWidget {

  const HelpSupportScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text("Help & Support"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: ListView(

          children: [

            const Center(

              child: CircleAvatar(
                radius: 50,
                backgroundColor:
                    Colors.green,

                child: Icon(
                  Icons.support_agent,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 25),

            buildSupportCard(
              Icons.call,
              "Farmer Helpline",
              "+91 1800-123-456",
            ),

            buildSupportCard(
              Icons.email,
              "Email Support",
              "support@krishimithra.com",
            ),

            buildSupportCard(
              Icons.location_on,
              "Agriculture Office",
              "Nearest Mandal Office",
            ),

            buildSupportCard(
              Icons.question_answer,
              "FAQ",
              "Frequently Asked Questions",
            ),

          ],
        ),
      ),
    );
  }

  Widget buildSupportCard(
    IconData icon,
    String title,
    String subtitle,
  ) {

    return Card(

      margin:
          const EdgeInsets.only(
        bottom: 18,
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
            fontSize: 18,
          ),
        ),

        subtitle: Text(
          subtitle,

          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}