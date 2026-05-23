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

      theme: ThemeData(

        primarySwatch: Colors.green,

        scaffoldBackgroundColor: const Color(0xFFF4FDF3),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          centerTitle: true,
          elevation: 2,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(

          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        cardTheme: CardThemeData(

          elevation: 5,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),

      home: const SplashScreen(),
    );
  }
}