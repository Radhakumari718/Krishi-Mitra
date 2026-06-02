import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Choose Payment Method",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.account_balance,
                  color: Colors.green,
                ),
                title: const Text("UPI Payment"),
                subtitle:
                    const Text("Google Pay / PhonePe / Paytm"),
                onTap: () {
                  _showSuccess(context);
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.money,
                  color: Colors.green,
                ),
                title:
                    const Text("Cash On Delivery"),
                subtitle:
                    const Text("Pay when order arrives"),
                onTap: () {
                  _showSuccess(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccess(BuildContext context) {

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text("Success 🎉"),

          content: const Text(
            "Payment Successful!\nOrder Placed Successfully.",
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(context);

              },

              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}