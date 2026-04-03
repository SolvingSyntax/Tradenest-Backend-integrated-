import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const primary = Color(0xFF1F2937);
  static const accent = Color(0xFFF59E0B);
  static const bg = Color(0xFFF9FAFB);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> orders = [
      {"id": "#TN-8472", "name": "Bosch Drill Pro", "date": "12 Oct, 2023", "price": "₹4,999", "status": "Delivered", "color": Colors.green},
      {"id": "#TN-8499", "name": "Makita Angle Grinder", "date": "24 Nov, 2023", "price": "₹3,799", "status": "In Transit", "color": accent},
      {"id": "#TN-8501", "name": "Stanley Wrench Set", "date": "02 Dec, 2023", "price": "₹2,199", "status": "Cancelled", "color": Colors.redAccent},
    ];

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: primary), onPressed: () => Navigator.pop(context)),
        title: const Text("My Orders", style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(order["id"], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: order["color"].withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: Text(order["status"], style: TextStyle(color: order["color"], fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.handyman, color: primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(order["name"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: primary)),
                          const SizedBox(height: 4),
                          Text("Ordered on ${order["date"]}", style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                        ],
                      ),
                    ),
                    Text(order["price"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: accent)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}