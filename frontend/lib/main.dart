import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const KrishiMithraApp());
}

class KrishiMithraApp extends StatelessWidget {
  const KrishiMithraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Krishi Mithra',
      home: SplashScreen(),
    );
  }
}