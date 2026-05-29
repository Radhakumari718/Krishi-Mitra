import 'package:flutter/material.dart';

class PricePredictionScreen
    extends StatefulWidget {

  const PricePredictionScreen({
    super.key,
  });

  @override
  State<PricePredictionScreen>
      createState() =>
          _PricePredictionScreenState();
}

class _PricePredictionScreenState
    extends State<PricePredictionScreen> {

  final TextEditingController cropController =
      TextEditingController();

  String result = "";

  void predictPrice() {

    String crop =
        cropController.text.toLowerCase();

    if (crop.contains("rice")) {

      result =
          "Predicted Price:\n₹2800 / Quintal 📈";

    } else if (crop.contains("wheat")) {

      result =
          "Predicted Price:\n₹2400 / Quintal 📊";

    } else if (crop.contains("tomato")) {

      result =
          "Predicted Price:\n₹50 / Kg 🍅";

    } else {

      result =
          "Price data unavailable";
    }

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text("Price Prediction"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller:
                  cropController,

              decoration:
                  const InputDecoration(
                labelText:
                    "Enter Crop Name",

                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                onPressed:
                    predictPrice,

                child: const Text(
                  "Predict Price",

                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            Text(
              result,

              textAlign:
                  TextAlign.center,

              style: const TextStyle(
                fontSize: 26,
                fontWeight:
                    FontWeight.bold,
                color: Colors.green,
              ),
            ),

          ],
        ),
      ),
    );
  }
}