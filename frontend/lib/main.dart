import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://mvkjzjxtgdjwqxixtrxm.supabase.co',         // ← mee URL ikkada
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im12a2p6anh0Z2Rqd3F4aXh0cnhtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzk2MTY5NjIsImV4cCI6MjA5NTE5Mjk2Mn0.3WCIcnwVh7rWtGFRZLb8FhubC6BQdLVle9wIqwt_s7Y', // ← mee key ikkada
  );
  
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