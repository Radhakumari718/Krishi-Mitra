import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> listings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchListings();
  }

  Future<void> fetchListings() async {
    setState(() => isLoading = true);
    try {
      final data = await supabase
          .from('marketplace')
          .select()
          .eq('is_available', true)
          .order('created_at', ascending: false);

      setState(() {
        listings  = List<Map<String, dynamic>>.from(data);
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> buyItem(Map<String, dynamic> listing) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      // Orders table lo insert cheyandi
      await supabase.from('orders').insert({
        'buyer_id'   : userId,
        'listing_id' : listing['id'],
        'quantity'   : 1,
        'total_price': listing['price'],
        'status'     : 'pending',
      });

      // Marketplace lo is_available false cheyandi
      await supabase
          .from('marketplace')
          .update({'is_available': false})
          .eq('id', listing['id']);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${listing['crop_name']} order placed! ✅'),
          backgroundColor: Colors.green,
        ),
      );

      // Refresh cheyandi
      fetchListings();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order failed: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> addListing() async {
    final cropController     = TextEditingController();
    final priceController    = TextEditingController();
    final quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Listing'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: cropController,
              decoration: const InputDecoration(
                labelText: 'Crop Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Price (₹ per Quintal)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity (Quintal)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final userId = supabase.auth.currentUser!.id;
                await supabase.from('marketplace').insert({
                  'seller_id'   : userId,
                  'crop_name'   : cropController.text.trim(),
                  'price'       : double.parse(priceController.text.trim()),
                  'quantity'    : double.parse(quantityController.text.trim()),
                  'unit'        : 'Quintal',
                  'is_available': true,
                });

                Navigator.pop(context);
                fetchListings();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Listing added! ✅'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Marketplace"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchListings,
          ),
        ],
      ),

      // Sell button — listing add cheyataniki
      floatingActionButton: FloatingActionButton(
        onPressed: addListing,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : listings.isEmpty
              ? const Center(
                  child: Text(
                    'No listings available\n+ button tho add cheyandi!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                    itemCount: listings.length,
                    itemBuilder: (context, index) {
                      final item = listings[index];
                      return cropCard(item);
                    },
                  ),
                ),
    );
  }

  Widget cropCard(Map<String, dynamic> item) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.grass, size: 50, color: Colors.green),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['crop_name'] ?? '',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '₹${item['price']} / ${item['unit'] ?? 'Quintal'}',
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
                    'Qty: ${item['quantity']} ${item['unit'] ?? 'Quintal'}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => buyItem(item),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Buy', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}