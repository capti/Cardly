import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E3),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/карты.png',
                height: 80,
                color: const Color(0xFFD9A76A),
              ),
              const SizedBox(height: 20),
              const Text(
                'Cardly',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFFD9A76A),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD9A76A)),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 