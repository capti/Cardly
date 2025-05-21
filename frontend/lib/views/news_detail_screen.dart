import 'package:flutter/material.dart';
import 'news_screen.dart'; // Import NewsItem class

// Remove unused imports
// import 'home_screen.dart';
// import 'shop_screen.dart';
// import 'exchanges_screen.dart';
// import 'profile_screen.dart';
// import 'search_players_screen.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsItem news;
  
  const NewsDetailScreen({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFEAD7C3), // Match dialog background color style
      insetPadding: EdgeInsets.zero, // Remove default dialog padding
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Match border radius style
        side: const BorderSide(color: Colors.black, width: 2), // Match border style
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0), // Adjust padding as needed
            child: SingleChildScrollView( // Keep SingleChildScrollView for content that might overflow
              child: Column(
                mainAxisSize: MainAxisSize.min, // Use min size for column
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // News content - Title, Image, Full Content, Date
                  Center( // Center the title
                    child: Text(
                      news.title, // Use news object directly in StatelessWidget
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  const SizedBox(height: 24.0), // Keep spacing
                  
                  // Картинка
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAD7C3),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.black, width: 1.0), // Added thin black border
                    ),
                    alignment: Alignment.center,
                    child: const Center( // Use Center to center the text
                      child: Text(
                        'Нет изображения', // Use the placeholder text from inventory card
                        style: TextStyle(
                          color: Colors.black45, // Use the text color from inventory card
                          fontSize: 16.0, // Adjust font size as needed for this larger area
                          // fontWeight: FontWeight.bold, // Remove bold fontWeight
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24.0), // Keep spacing
                  
                  // Расширенное описание
                  Text(
                    news.fullContent, // Use news object directly
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  
                  const SizedBox(height: 16.0), // Keep spacing
                  
                  // Дата
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Дата публикации: ${news.date}', // Use news object directly
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Close button in the top right corner
          Positioned(
            top: 0, // Adjust position as needed
            right: 0, // Adjust position as needed
            child: GestureDetector(
              onTap: () => Navigator.pop(context), // Close the dialog
              child: Container(
                width: 48, // Match size from exchange_details_screen.dart
                height: 48, // Match size from exchange_details_screen.dart
                decoration: BoxDecoration(
                  color: Color(0xFFD6A067), // Match color
                  borderRadius: BorderRadius.circular(10), // Match border radius
                  border: Border.all(color: Colors.black, width: 3), // Match border style
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 28, // Match icon size
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 