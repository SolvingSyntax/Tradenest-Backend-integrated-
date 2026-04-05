import 'package:firebase_auth/firebase_auth.dart'; // Add this import
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/auth/welcome_screen.dart';
import 'screens/home_screen.dart'; // Ensure your home screen path is correct

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  } else {
    Firebase.app();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // The Gatekeeper logic starts here:
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // 1. If Firebase is still checking the session, show a loading spinner
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(color: Color(0xFF22A45D))),
            );
          }

          // 2. If a User is found (Snapshot has data), skip Welcome and go to Home
          if (snapshot.hasData) {
            return const HomeScreen();
          }

          // 3. Otherwise, show the Welcome/Login screen
          return const WelcomeScreen();
        },
      ),
    );
  }
}