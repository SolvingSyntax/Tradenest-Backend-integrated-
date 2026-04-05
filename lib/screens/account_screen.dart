import 'package:flutter/material.dart';
import 'payment_methods_screen.dart';
import 'orders_screen.dart';
import 'addresses_screen.dart';
import 'coupons_screen.dart';
import 'settings_screen.dart';
import 'support_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  static const primary = Color(0xFF1F2937);
  static const accent = Color(0xFFF59E0B);
  static const bg = Color(0xFFF9FAFB);

  @override
  Widget build(BuildContext context) {
    // 🔥 Get current user UID
    final String uid = FirebaseAuth.instance.currentUser!.uid;

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
          "My Account",
          style: TextStyle(
            color: primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        // 🔥 Fetch real data from your Firestore 'users' collection
        future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: accent));
          }

          // Default values if data is missing
          String fullName = "User Name";
          String email = "No Email Found";

          if (snapshot.hasData && snapshot.data!.exists) {
            var userData = snapshot.data!.data() as Map<String, dynamic>;
            fullName = userData['name'] ?? "Add Name";
            email = userData['email'] ?? "No Email";
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                /// 🔹 PROFILE HEADER (Design preserved)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: accent.withOpacity(0.2),
                        child: const Icon(Icons.person, size: 40, color: accent),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullName, // 🔥 REAL NAME
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              email, // 🔥 REAL EMAIL
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_square, color: primary),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Edit Profile Clicked!')),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                /// 🔹 MAIN MENU OPTIONS
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildMenuOption(context, Icons.inventory_2_outlined, "My Orders", "Track, return, or buy again", const OrdersScreen()),
                      _divider(),
                      _buildMenuOption(context, Icons.location_on_outlined, "Shipping Addresses", "Manage delivery locations", const AddressesScreen()),
                      _divider(),
                      _buildMenuOption(context, Icons.credit_card_outlined, "Payment Methods", "Cards, UPI, and Wallets", const PaymentMethodsScreen()),
                      _divider(),
                      _buildMenuOption(context, Icons.local_offer_outlined, "Coupons & Offers", "View your saved discounts", const CouponsScreen()),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// 🔹 SETTINGS & SUPPORT
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildMenuOption(context, Icons.settings_outlined, "Settings", "Notifications, Password, Language", const SettingsScreen()),
                      _divider(),
                      _buildMenuOption(context, Icons.help_outline, "Help & Support", "FAQs and Customer Service", const SupportScreen()),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                /// 🔹 LOGOUT BUTTON (Logic Added)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.withOpacity(0.1),
                      foregroundColor: Colors.redAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.logout),
                    label: const Text(
                      "Log Out",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      // 🔥 ACTUAL LOGOUT LOGIC
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        // The StreamBuilder in main.dart will automatically
                        // detect this and show the WelcomeScreen.
                        Navigator.pop(context); 
                      }
                    },
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuOption(BuildContext context, IconData icon, String title, String subtitle, Widget? targetScreen) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: primary),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: primary),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        if (targetScreen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title page coming soon!')),
          );
        }
      },
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(height: 1, color: Colors.grey.shade200),
    );
  }
}