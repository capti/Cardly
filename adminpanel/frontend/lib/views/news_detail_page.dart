import 'package:flutter/material.dart';
import 'package:adminpanel/views/widgets/navbar.dart';
import 'dart:typed_data';

class NewsDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final Uint8List? imageBytes;

  const NewsDetailPage({
    Key? key,
    required this.title,
    required this.description,
    this.imageBytes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: const NavBar(active: 'Новости', showBack: false),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2A86F),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.arrow_back, size: 28, color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 700,
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7E5CF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    if (imageBytes != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(imageBytes!, fit: BoxFit.cover, width: 450, height: 180),
                      )
                    else
                      Container(
                        width: 450,
                        height: 180,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2A86F),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(child: Text('Нет изображения', style: TextStyle(fontSize: 14))),
                      ),
                    const SizedBox(height: 32),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 