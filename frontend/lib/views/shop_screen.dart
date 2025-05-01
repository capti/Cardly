import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4E3),
        elevation: 0,
        title: const Text('Магазин', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const Center(
        child: Text('Экран магазина', style: TextStyle(fontSize: 24)),
      ),
    );
  }
} 