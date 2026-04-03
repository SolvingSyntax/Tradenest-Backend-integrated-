import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  static const primary = Color(0xFF1F2937);
  static const accent = Color(0xFFF59E0B);
  static const bg = Color(0xFFF9FAFB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: primary), onPressed: () => Navigator.pop(context)),
        title: const Text("Help & Support", style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                const Text("How can we help you today?", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _contactButton(context, Icons.chat, "Live Chat")),
                    const SizedBox(width: 16),
                    Expanded(child: _contactButton(context, Icons.call, "Call Us")),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Text("FREQUENTLY ASKED QUESTIONS", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 16),
          _buildFAQ("How do I track my order?", "You can track your order by navigating to My Account > My Orders and clicking on the specific order."),
          _buildFAQ("What is your return policy?", "We offer a 7-day hassle-free return policy for unused tools in their original packaging."),
          _buildFAQ("Do you offer bulk discounts?", "Yes! Please contact our support team via Live Chat for wholesale inquiries."),
        ],
      ),
    );
  }

  Widget _contactButton(BuildContext context, IconData icon, String title) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: primary,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(icon, size: 20),
      label: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Starting $title...'))),
    );
  }

  Widget _buildFAQ(String question, String answer) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.bold, color: primary, fontSize: 15)),
        iconColor: accent,
        childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        children: [Text(answer, style: TextStyle(color: Colors.grey.shade700, height: 1.5))],
      ),
    );
  }
}