import 'package:flutter/material.dart';
import 'product_detail_screen.dart'; // 🔥 Imported the detail screen

class GrinderScreen extends StatelessWidget {
  const GrinderScreen({super.key});

  // 🔥 Updated to a List of Maps to hold both the name and a dummy price
  final List<Map<String, String>> grinders = const [
    {"name": "Angle Grinder", "price": "₹2,999"},
    {"name": "Bench Grinder", "price": "₹5,499"},
    {"name": "Die Grinder", "price": "₹3,199"},
    {"name": "Straight Grinder", "price": "₹4,599"},
    {"name": "Cordless Grinder", "price": "₹6,999"},
    {"name": "Mini Grinder", "price": "₹1,499"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grinder Types")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: grinders.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
          ),
          itemBuilder: (context, index) {
            final grinder = grinders[index]; // Get the current grinder data

            // 🔥 Wrapped the Container in an InkWell to make it clickable
            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                // Navigate to the ProductDetailScreen and pass the specific name and price
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      name: grinder["name"]!,
                      price: grinder["price"]!,
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
                  grinder["name"]!, // Display the name from our updated list
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}