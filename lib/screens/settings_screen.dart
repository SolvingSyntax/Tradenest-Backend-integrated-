import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const primary = Color(0xFF1F2937);
  static const accent = Color(0xFFF59E0B);
  static const bg = Color(0xFFF9FAFB);

  bool pushNotifications = true;
  bool emailPromos = false;
  bool faceId = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: primary), onPressed: () => Navigator.pop(context)),
        title: const Text("Settings", style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("NOTIFICATIONS", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 10),
          _buildSwitch("Push Notifications", pushNotifications, (val) => setState(() => pushNotifications = val)),
          _buildSwitch("Email Promotions", emailPromos, (val) => setState(() => emailPromos = val)),
          
          const SizedBox(height: 30),
          const Text("SECURITY", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 10),
          _buildSwitch("Enable Face ID / Fingerprint", faceId, (val) => setState(() => faceId = val)),
          ListTile(
            title: const Text("Change Password", style: TextStyle(fontWeight: FontWeight.w500, color: primary)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          
          const SizedBox(height: 30),
          const Text("PREFERENCES", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 10),
          ListTile(
            title: const Text("Language", style: TextStyle(fontWeight: FontWeight.w500, color: primary)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("English", style: TextStyle(color: Colors.grey)),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSwitch(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, color: primary)),
      value: value,
      activeThumbColor: accent,
      onChanged: onChanged,
    );
  }
}