import 'package:flutter/material.dart';

class GrinderScreen extends StatelessWidget {
  const GrinderScreen({super.key});

  final List<String> grinders = const [
    "Angle Grinder",
    "Bench Grinder",
    "Die Grinder",
    "Straight Grinder",
    "Cordless Grinder",
    "Mini Grinder",
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
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                grinders[index],
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            );
          },
        ),
      ),
    );
  }
}
