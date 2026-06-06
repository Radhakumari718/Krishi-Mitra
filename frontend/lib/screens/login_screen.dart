import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'farmer_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool isLoading = false;
  bool isLoginMode = true;

  Future<void> login() async {
    setState(() => isLoading = true);
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FarmerDashboard()),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> signup() async {
    setState(() => isLoading = true);
    try {
      await Supabase.instance.client.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        data: {'name': nameController.text.trim()},
      );

      // Trigger automatically profiles lo insert chestondi
      // Manual insert cheyakuradu!

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FarmerDashboard()),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Krishi Mithra'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(Icons.agriculture, size: 100, color: Colors.green),
            const SizedBox(height: 20),

            Text(
              isLoginMode ? "Welcome Back!" : "Create Account",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Name field — only signup lo
            if (!isLoginMode) ...[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
            ],

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : (isLoginMode ? login : signup),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(15),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        isLoginMode ? "Login" : "Sign Up",
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ),
            const SizedBox(height: 20),

            // Toggle Login/Signup
            TextButton(
              onPressed: () => setState(() => isLoginMode = !isLoginMode),
              child: Text(
                isLoginMode
                    ? "Account leada? Sign Up cheyandi"
                    : "Already account unda? Login cheyandi",
                style: const TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}