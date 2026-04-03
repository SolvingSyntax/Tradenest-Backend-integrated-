import 'package:flutter/material.dart';
import 'product_detail_screen.dart'; // 1. Added the import

class DrillScreen extends StatelessWidget {
  const DrillScreen({super.key});

  // 2. Updated the list to hold both names and dummy prices
  final List<Map<String, String>> drills = const [
    {"name": "Cordless Drill", "price": "₹3,499"},
    {"name": "Hammer Drill", "price": "₹4,299"},
    {"name": "Impact Drill", "price": "₹5,999"},
    {"name": "Rotary Drill", "price": "₹6,199"},
    {"name": "Bench Drill", "price": "₹12,499"},
    {"name": "Magnetic Drill", "price": "₹18,999"},
    {"name": "Right Angle Drill", "price": "₹4,599"},
    {"name": "Core Drill", "price": "₹22,999"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drill Types"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: drills.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
          ),
          itemBuilder: (context, index) {
            final drill = drills[index]; // Get the current drill

            // 3. Wrapped the Container in a GestureDetector
            return GestureDetector(
              onTap: () {
                // Navigate to the ProductDetailScreen and pass the data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      name: drill["name"]!,
                      price: drill["price"]!,
                    ),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  drill["name"]!, // Display the name from the map
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}