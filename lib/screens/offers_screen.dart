import 'package:flutter/material.dart';
import 'product_detail_screen.dart'; // So users can click discounted items

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  static const primary = Color(0xFF1F2937);
  static const accent = Color(0xFFF59E0B);
  static const bg = Color(0xFFF9FAFB);

  @override
  Widget build(BuildContext context) {
    // 🔥 Dummy Data for Discounted Items
    final List<Map<String, String>> discountedItems = [
      {"name": "Bosch Drill Pro", "oldPrice": "₹6,999", "newPrice": "₹4,999", "discount": "28% OFF"},
      {"name": "Makita Angle Grinder", "oldPrice": "₹4,500", "newPrice": "₹3,799", "discount": "15% OFF"},
      {"name": "DeWalt Table Saw", "oldPrice": "₹18,000", "newPrice": "₹15,499", "discount": "14% OFF"},
    ];

    // 🔥 Dummy Data for Out of Stock Items
    final List<Map<String, String>> outOfStockItems = [
      {"name": "Cordless Mini Grinder", "restock": "Back in 3 Days"},
      {"name": "Magnetic Core Drill", "restock": "Out of Stock"},
    ];

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Offers & Updates",
          style: TextStyle(
            color: primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            /// 🔹 BIG PROMO BANNER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [accent, Color(0xFFD97706)], // Orange gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: accent.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "LIMITED TIME",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: accent),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Weekend Tool Clearance!",
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Get up to 30% off on selected power tools. Hurry, while stocks last.",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            /// 🔹 DISCOUNTED ITEMS SECTION
            _buildSectionTitle("🔥 Top Discounts"),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: discountedItems.length,
              itemBuilder: (context, index) {
                final item = discountedItems[index];
                return GestureDetector(
                  onTap: () {
                    // Let users click the sale item to buy it!
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          name: item["name"]!,
                          price: item["newPrice"]!,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: accent.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.handyman, color: accent),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["name"]!,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: primary),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    item["newPrice"]!,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: accent),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    item["oldPrice"]!,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough, // Crosses out old price
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item["discount"]!,
                            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),

            /// 🔹 OUT OF STOCK SECTION
            _buildSectionTitle("⚠️ Out of Stock"),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: outOfStockItems.length,
              itemBuilder: (context, index) {
                final item = outOfStockItems[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100, // Grey background to look disabled
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.build, color: Colors.grey), // Grey icon
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["name"]!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item["restock"]!,
                              style: const TextStyle(color: Colors.redAccent, fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.notifications_active_outlined, color: Colors.grey),
                    ],
                  ),
                );
              },
            ),
            
            const SizedBox(height: 40), // Padding at the bottom
          ],
        ),
      ),
    );
  }

  // Helper widget to easily create titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
    );
  }
}