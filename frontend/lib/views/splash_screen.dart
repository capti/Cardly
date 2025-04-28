import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthScreen()),
      );
    });
  }

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
              const SizedBox(height: 100),

            ],
          ),
        ),
      ),
    );
  }
} 