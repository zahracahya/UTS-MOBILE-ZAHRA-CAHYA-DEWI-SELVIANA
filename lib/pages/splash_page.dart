import 'dart:async';
import 'package:flutter/material.dart';
import 'dashboard_page.dart'; 

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF55301),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Foto
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/profile1.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Daily LifeApp',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'ZAHRA CAHYA DEWI SELVIANA',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const Text(
              '152022131',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),

            const SizedBox(height: 40),

            // Loading Animation
            const CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
