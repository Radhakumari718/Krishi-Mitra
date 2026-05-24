import 'package:flutter/material.dart';

class SellProductScreen extends StatefulWidget {

  const SellProductScreen({
    super.key,
  });

  @override
  State<SellProductScreen>
      createState() =>
          _SellProductScreenState();
}

class _SellProductScreenState
    extends State<SellProductScreen> {

  final TextEditingController
      cropController =
      TextEditingController();

  final TextEditingController
      quantityController =
      TextEditingController();

  final TextEditingController
      priceController =
      TextEditingController();

  final TextEditingController
      locationController =
      TextEditingController();

  void uploadProduct() {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content: Text(
          "Product Uploaded Successfully 🌾",
        ),
      ),
    );

    cropController.clear();
    quantityController.clear();
    priceController.clear();
    locationController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text("Sell Product"),
        backgroundColor: Colors.green,
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            const Icon(
              Icons.store,
              size: 100,
              color: Colors.green,
            ),

            const SizedBox(height: 20),

            TextField(
              controller: cropController,

              decoration:
                  const InputDecoration(
                labelText:
                    "Crop Name",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  quantityController,

              decoration:
                  const InputDecoration(
                labelText:
                    "Quantity",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  priceController,

              decoration:
                  const InputDecoration(
                labelText:
                    "Price",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  locationController,

              decoration:
                  const InputDecoration(
                labelText:
                    "Location",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                onPressed:
                    uploadProduct,

                child: const Text(
                  "Upload Product",

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
}