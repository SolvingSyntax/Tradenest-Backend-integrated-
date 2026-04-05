import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static const primary = Color(0xFF1F2937);
  static const bg = Color(0xFFF9FAFB);
  static const accent = Color(0xFFF59E0B);

  CollectionReference get _cartCollection => FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('cart');

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
        title: const Text(
          "My Cart",
          style: TextStyle(
            color: primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _cartCollection.orderBy('addedAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: accent));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _buildEmptyCart();
          }

          final cartDocs = snapshot.data!.docs;

          return Column(
            children: [
              Expanded(child: _buildCartList(cartDocs)),
              // Pass the docs to the button so we can process them
              _buildCheckoutButton(cartDocs),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text(
            "Your cart is empty",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primary),
          ),
          const SizedBox(height: 8),
          Text("Looks like you haven't added any tools yet.",
              style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: accent,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text("Start Shopping",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildCartList(List<QueryDocumentSnapshot> docs) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final item = docs[index].data() as Map<String, dynamic>;
        final docId = docs[index].id;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.handyman, color: primary, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["name"] ?? "Unknown Tool",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "₹${item["price"] ?? "0"}",
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: accent),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () async {
                  await _cartCollection.doc(docId).delete();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // 🔥 UPDATED: Added logic to handle the checkout process
  Widget _buildCheckoutButton(List<QueryDocumentSnapshot> cartDocs) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          )
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: () async {
            try {
              final user = FirebaseAuth.instance.currentUser;
              if (user == null) return;

              // 1. Calculate Total
              double total = 0;
              List<Map<String, dynamic>> orderItems = [];

              for (var doc in cartDocs) {
                final data = doc.data() as Map<String, dynamic>;
                // Handle price parsing safely
                double price = double.tryParse(data['price'].toString()) ?? 0.0;
                total += price;
                
                orderItems.add({
                  'productId': doc.id,
                  'name': data['name'],
                  'price': price,
                  'quantity': 1, // Defaulting to 1 for now
                });
              }

              // 2. Create Order Object
              final newOrder = OrderModel(
                userId: user.uid,
                totalAmount: total,
                status: "pending",
                createdAt: DateTime.now(),
                address: "Mumbai, Maharashtra", // Dynamic later
                items: orderItems,
              );

              // 3. Write to Firestore using a Batch for safety
              WriteBatch batch = FirebaseFirestore.instance.batch();
              
              // Add Order
              DocumentReference orderRef = FirebaseFirestore.instance.collection('orders').doc();
              batch.set(orderRef, newOrder.toMap());

              // Clear Cart (Delete all items in user's cart subcollection)
              for (var doc in cartDocs) {
                batch.delete(doc.reference);
              }

              await batch.commit();

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order Placed Successfully!'), backgroundColor: Colors.green),
                );
                // Future Step: Navigator.push to Success Screen
              }
            } catch (e) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
                );
              }
            }
          },
          child: const Center(
            child: Text(
              "Proceed to Checkout",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}