import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../utils/product_data.dart';
import '../utils/storage_service.dart';

class SellProductScreen extends StatefulWidget {
  const SellProductScreen({super.key});
  @override
  State<SellProductScreen> createState() => _SellProductScreenState();
}

class _SellProductScreenState extends State<SellProductScreen> {
  final farmerController = TextEditingController();
  final cropController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();
  Uint8List? imageBytes;
  final picker = ImagePicker();
  bool isUploading = false;
  final supabase = Supabase.instance.client;

  Future<void> pickImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageBytes = await image.readAsBytes();
      setState(() {});
    }
  }

  Future<String?> _uploadImage() async {
    if (imageBytes == null) return null;

    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

      await supabase.storage.from('product-images').uploadBinary(
            fileName,
            imageBytes!,
            fileOptions: const FileOptions(contentType: 'image/jpeg'),
          );

      final publicUrl = supabase.storage.from('product-images').getPublicUrl(fileName);
      return publicUrl;
    } catch (e) {
      debugPrint('Image upload failed: $e');
      return null;
    }
  }

  Future<void> uploadProduct() async {
    if (cropController.text.trim().isEmpty || priceController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill in crop name and price')));
      return;
    }

    setState(() => isUploading = true);

    try {
      final imageUrl = await _uploadImage();

      await ProductData.addProduct({
        'name': cropController.text,
        'price': '₹${priceController.text}',
        'quantity': quantityController.text,
        'location': locationController.text,
        'farmer': farmerController.text,
        'image_url': imageUrl,
      });

      await StorageService.saveProducts(ProductData.products);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product listed successfully 🌾'), backgroundColor: Color(0xFF1a6b2e)),
      );

      farmerController.clear();
      cropController.clear();
      quantityController.clear();
      priceController.clear();
      locationController.clear();
      setState(() => imageBytes = null);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to list product: $e')),
      );
    } finally {
      if (mounted) setState(() => isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('List a product'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF1a6b2e), width: 1.5, style: BorderStyle.solid),
                ),
                child: imageBytes != null
                    ? ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.memory(imageBytes!, fit: BoxFit.cover, width: double.infinity))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add_a_photo_outlined, size: 36, color: Color(0xFF1a6b2e)),
                          SizedBox(height: 8),
                          Text('Add product photo', style: TextStyle(color: Color(0xFF1a6b2e), fontWeight: FontWeight.w600)),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 18),
            _sectionCard([
              _field(farmerController, 'Farmer name', Icons.person_outline),
              _field(cropController, 'Crop / product name', Icons.eco_outlined),
              _field(quantityController, 'Quantity available (e.g. 100 kg)', Icons.inventory_2_outlined),
              _field(priceController, 'Price (₹ per unit)', Icons.currency_rupee, keyboardType: TextInputType.number),
              _field(locationController, 'Location / village', Icons.location_on_outlined, last: true),
            ]),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: isUploading ? null : uploadProduct,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1a6b2e), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: isUploading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('List product', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
      child: Column(children: children),
    );
  }

  Widget _field(TextEditingController controller, String label, IconData icon, {TextInputType? keyboardType, bool last = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 14),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFF1a6b2e), size: 20),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}