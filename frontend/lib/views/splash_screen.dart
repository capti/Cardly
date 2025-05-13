import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import 'auth_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    // Запускаем проверку авторизации с небольшой задержкой для отображения сплеш-скрина
    Timer(const Duration(seconds: 2), () {
      _checkAuth();
    });
  }
  
  Future<void> _checkAuth() async {
    final authController = Provider.of<AuthController>(context, listen: false);
    final isLoggedIn = await authController.tryAutoLogin();
    
    if (!mounted) return;
    
    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthScreen()),
      );
    }
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