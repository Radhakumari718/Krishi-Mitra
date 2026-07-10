import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        setState(() => isLoading = false);
        return;
      }

      final response = await supabase
          .from('orders')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      setState(() {
        orders = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Failed to load orders: $e');
      setState(() => isLoading = false);
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'delivered':
        return const Color(0xFF1a6b2e);
      case 'on the way':
        return const Color(0xFF1976D2);
      default:
        return const Color(0xFFf0a500);
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'delivered':
        return Icons.check_circle_outline;
      case 'on the way':
        return Icons.local_shipping_outlined;
      default:
        return Icons.schedule;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: const Color(0xFF1a6b2e),
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty
              ? Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('📦', style: TextStyle(fontSize: 60)),
                    const SizedBox(height: 12),
                    const Text('No orders yet', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ]),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(14),
                  itemCount: orders.length,
                  itemBuilder: (context, i) {
                    final order = orders[i];
                    final items = List<Map<String, dynamic>>.from(order['items'] ?? []);
                    final itemNames = items.map((item) => item['name']).join(', ');
                    final status = (order['status'] ?? 'pending').toString();
                    final color = _statusColor(status);
                    final createdAt = DateTime.tryParse(order['created_at'] ?? '');

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
                      child: Row(children: [
                        Container(
                          width: 46, height: 46,
                          decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                          child: Icon(_statusIcon(status), color: color),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(itemNames.isEmpty ? 'Order' : itemNames, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 3),
                              Text(status[0].toUpperCase() + status.substring(1), style: TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 2),
                              Text('₹${order['total']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                        Text(
                          createdAt != null ? '${createdAt.day}/${createdAt.month}/${createdAt.year}' : '',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ]),
                    );
                  },
                ),
    );
  }
}