import 'package:flutter/material.dart';
import 'product_detail_screen.dart'; // 🔥 Imported the detail screen

class SawScreen extends StatelessWidget {
  const SawScreen({super.key});

  // 🔥 Updated to a List of Maps to hold both the name and a dummy price
  final List<Map<String, String>> saws = const [
    {"name": "Circular Saw", "price": "₹5,499"},
    {"name": "Jigsaw", "price": "₹3,299"},
    {"name": "Table Saw", "price": "₹15,999"},
    {"name": "Band Saw", "price": "₹12,499"},
    {"name": "Miter Saw", "price": "₹18,999"},
    {"name": "Reciprocating Saw", "price": "₹6,499"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saw Types")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: saws.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
          ),
          itemBuilder: (context, index) {
            final saw = saws[index]; // Get the current saw data

            // 🔥 Wrapped the Container in an InkWell to make it clickable
            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                // Navigate to the ProductDetailScreen and pass the specific name and price
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      name: saw["name"]!,
                      price: saw["price"]!,
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
                  saw["name"]!, // Display the name from our updated list
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