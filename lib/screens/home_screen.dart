import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'drill_screen.dart';
import 'grinder_screen.dart';
import 'saw_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const primary = Color(0xFF1F2937);
  static const accent = Color(0xFFF59E0B);
  static const bg = Color(0xFFF9FAFB);

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔹 HEADER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    const Text(
                      "TradeNest",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),
                    const Spacer(),
                    _iconButton(Icons.search),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                      child: _iconButton(Icons.shopping_cart_outlined),
                    ),
                  ],
                ),
              ),

              /// 🔹 HERO
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [primary, Color(0xFF111827)],
                    ),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Power Your Projects",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Up to 30% off on premium tools",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: const BoxDecoration(
                          color: accent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.handyman,
                            color: Colors.white, size: 28),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// 🔹 CATEGORIES
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 110,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const DrillScreen()),
                        );
                      },
                      child: const _categoryCard(Icons.handyman, "Drills"),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const GrinderScreen()),
                        );
                      },
                      child: const _categoryCard(Icons.build, "Grinders"),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SawScreen()),
                        );
                      },
                      child: const _categoryCard(Icons.precision_manufacturing, "Saws"),
                    ),

                    const _categoryCard(Icons.settings, "Wrenches"),
                    const _categoryCard(Icons.construction, "Tool Kits"),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// 🔹 PRODUCTS
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Featured Tools",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                  children: const [
                    _productCard("Bosch Drill", "₹4,999"),
                    _productCard("Makita Grinder", "₹3,799"),
                    _productCard("DeWalt Saw", "₹6,499"),
                    _productCard("Stanley Wrench", "₹2,199"),
                  ],
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),

      /// 🔥 UPDATED BOTTOM NAV
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 65,
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 0),
              _buildNavItem(Icons.search, 1),
              _buildNavItem(Icons.shopping_cart, 2),
              _buildNavItem(Icons.receipt_long, 3),
              _buildNavItem(Icons.person, 4),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 NAV ITEM WITH NAVIGATION
  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });

        switch (index) {
          case 1:
            // TODO: Search Screen
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            );
            break;
          case 3:
            // TODO: Orders Screen
            break;
          case 4:
            // TODO: Profile Screen
            break;
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? accent : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white70,
        ),
      ),
    );
  }

  static Widget _iconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: primary),
    );
  }
}

class _categoryCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const _categoryCard(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFFF59E0B).withOpacity(0.15),
            child: Icon(icon, color: primary),
          ),
          const SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _productCard extends StatelessWidget {
  final String name;
  final String price;

  const _productCard(this.name, this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Center(
              child: Icon(Icons.build, size: 50),
            ),
          ),
          Text(name,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 6),
          Text(
            price,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFF59E0B),
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}


