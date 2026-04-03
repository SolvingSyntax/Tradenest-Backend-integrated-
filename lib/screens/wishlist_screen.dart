import 'package:flutter/material.dart';
import 'home_screen.dart'; // Gives us access to globalWishlist and globalCart

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  static const primary = Color(0xFF1F2937);
  static const bg = Color(0xFFF9FAFB);
  static const accent = Color(0xFFF59E0B);

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
          "My Wishlist",
          style: TextStyle(
            color: primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      
      // If the wishlist is empty, show the empty state, otherwise show the list
      body: globalWishlist.isEmpty 
          ? _buildEmptyWishlist() 
          : _buildWishlist(),
    );
  }

  /// 🔹 UI FOR WHEN THE WISHLIST IS EMPTY
  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text(
            "Nothing here yet",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Save your favorite tools for later!",
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  /// 🔹 UI FOR WHEN ITEMS ARE IN THE WISHLIST
  Widget _buildWishlist() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: globalWishlist.length,
      itemBuilder: (context, index) {
        final item = globalWishlist[index];
        
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
              // Tool Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.handyman, color: Colors.redAccent, size: 30),
              ),
              const SizedBox(width: 16),
              
              // Tool Name and Price
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["name"]!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item["price"]!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Move to Cart Button
              IconButton(
                icon: const Icon(Icons.add_shopping_cart, color: primary),
                onPressed: () {
                  // Add to cart
                  globalCart.add({
                    "name": item["name"]!,
                    "price": item["price"]!,
                  });
                  
                  // Show popup
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                        content: Text('${item["name"]} moved to Cart!'),
                        behavior: SnackBarBehavior.floating,
                     ),
                  );
                },
              ),

              // Delete Button
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.grey),
                onPressed: () {
                  setState(() {
                    globalWishlist.removeAt(index);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}