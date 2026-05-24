import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() {

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Krishi Mithra',

      theme: ThemeData(

        primarySwatch: Colors.green,

        elevatedButtonTheme:
            ElevatedButtonThemeData(

          style: ElevatedButton.styleFrom(

            backgroundColor: Colors.green,
            foregroundColor: Colors.white,

            padding:
                const EdgeInsets.symmetric(
              vertical: 14,
            ),

            shape:
                RoundedRectangleBorder(

              borderRadius:
                  BorderRadius.circular(
                12,
              ),
            ),
          ),
        ),
      ),

      home: const SplashScreen(),
    );
  }
}