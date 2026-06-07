import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/product_data.dart';

class SellProductScreen extends StatefulWidget {
  const SellProductScreen({
    super.key,
  });

  @override
  State<SellProductScreen> createState() =>
      _SellProductScreenState();
}

class _SellProductScreenState
    extends State<SellProductScreen> {

  final TextEditingController farmerController =
      TextEditingController();

  final TextEditingController cropController =
      TextEditingController();

  final TextEditingController quantityController =
      TextEditingController();

  final TextEditingController priceController =
      TextEditingController();

  final TextEditingController locationController =
      TextEditingController();

  Uint8List? imageBytes;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {

    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {

      imageBytes = await image.readAsBytes();

      setState(() {});
    }
  }

  void uploadProduct() {

    ProductData.products.add({

      "name": cropController.text,

      "price": "₹${priceController.text}",

      "quantity": quantityController.text,

      "location": locationController.text,

      "farmer": farmerController.text,

      "imageBytes": imageBytes,
    });

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(
        content: Text(
          "Product Uploaded Successfully 🌾",
        ),
      ),
    );

    farmerController.clear();
    cropController.clear();
    quantityController.clear();
    priceController.clear();
    locationController.clear();

    setState(() {
      imageBytes = null;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Sell Product"),
        backgroundColor: Colors.green,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const Icon(
              Icons.store,
              size: 100,
              color: Colors.green,
            ),

            const SizedBox(height: 20),

            TextField(
              controller: farmerController,
              decoration: const InputDecoration(
                labelText: "Farmer Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: cropController,
              decoration: const InputDecoration(
                labelText: "Crop Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: quantityController,
              decoration: const InputDecoration(
                labelText: "Quantity",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: "Price",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: "Location",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(

              onPressed: pickImage,

              icon: const Icon(Icons.image),

              label: const Text(
                "Choose Product Image",
              ),
            ),

            const SizedBox(height: 20),

            if (imageBytes != null)

              Image.memory(
                imageBytes!,
                height: 200,
              ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                onPressed: uploadProduct,

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