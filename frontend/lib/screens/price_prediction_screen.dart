import 'package:flutter/material.dart';

class PricePredictionScreen extends StatefulWidget {
  const PricePredictionScreen({super.key});

  @override
  State<PricePredictionScreen> createState() =>
      _PricePredictionScreenState();
}

class _PricePredictionScreenState
    extends State<PricePredictionScreen> {

  final TextEditingController cropController =
      TextEditingController();

  final TextEditingController priceController =
      TextEditingController();

  String result = "";

  void predictPrice() {

    String crop = cropController.text.toLowerCase();

    if (crop == "rice") {

      result = "Predicted Future Price: ₹2800";

    } else if (crop == "wheat") {

      result = "Predicted Future Price: ₹2400";

    } else {

      result = "Predicted Future Price: ₹2000";
    }

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Price Prediction"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: cropController,

              decoration: const InputDecoration(
                labelText: "Crop Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: priceController,

              decoration: const InputDecoration(
                labelText: "Current Market Price",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: predictPrice,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(15),
                ),

                child: const Text(
                  "Predict Price",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              result,

              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

          ],
        ),
      ),
    );
  }
}