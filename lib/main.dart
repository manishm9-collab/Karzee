import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login.dart';
import 'screens/dashboard.dart';
import 'screens/profile.dart';
import 'screens/explore.dart'; // New Import Added

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Karzee',
      theme: ThemeData(
        primaryColor: const Color(0xFF0F6B4A),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F6B4A)),
        useMaterial3: true,
      ),
      // Starts the app at the Login Screen
      home: const LoginScreen(),
      
      // Named Routes for clean navigation
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const Dashboard(),
        '/profile': (context) => const ProfilePage(),
        '/explore': (context) => const ExplorePage(), // New Route Added
      },
    );
  }
}