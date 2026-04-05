import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // 🔥 Added this
import 'package:firebase_auth/firebase_auth.dart';    // 🔥 Added this
import 'home_screen.dart'; 

class ProductDetailScreen extends StatelessWidget {
  final String name;
  final String price;

  const ProductDetailScreen({
    super.key,
    required this.name,
    required this.price,
  });

  static const primary = Color(0xFF1F2937);
  static const accent = Color(0xFFF59E0B);
  static const bg = Color(0xFFF9FAFB);

  // 🔥 NEW: Function to send data to Firestore
  Future<void> _addToFirebaseCart(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login to add items to cart')),
      );
      return;
    }

    try {
      // We use the product name as the ID so it doesn't duplicate 
      // OR you can use .add() to allow multiple of the same tool
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .doc(name) // Using name as unique ID for this slot
          .set({
        "name": name,
        "price": price,
        "addedAt": FieldValue.serverTimestamp(),
        "quantity": 1,
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$name added to cart!'),
            backgroundColor: accent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      print("Error adding to cart: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: primary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.redAccent),
            onPressed: () {
              // Note: You should eventually move Wishlist to Firebase too!
              globalWishlist.add({"name": name, "price": price});
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$name added to Wishlist! ❤️'), backgroundColor: Colors.redAccent),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: bg),
              child: const Center(
                child: Icon(Icons.build, size: 120, color: primary),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primary)),
                      Row(
                        children: const [
                          Icon(Icons.star, color: accent, size: 20),
                          SizedBox(width: 4),
                          Text("4.8", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(price, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: accent)),
                  const SizedBox(height: 24),
                  const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primary)),
                  const SizedBox(height: 12),
                  const Text(
                    "This premium tool is built for durability and precision. It features an ergonomic grip, high-torque output, and a lightweight design.",
                    style: TextStyle(fontSize: 15, color: Colors.black54, height: 1.5),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 5,
                      ),
                      onPressed: () => _addToFirebaseCart(context), // 🔥 Fixed here
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}