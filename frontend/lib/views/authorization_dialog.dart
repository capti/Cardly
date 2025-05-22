import 'package:flutter/material.dart';

class AuthorizationDialog extends StatelessWidget {
  const AuthorizationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFFFF4E3), // Match background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        clipBehavior: Clip.none, // Allows positioned elements outside the stack bounds
        children: [
          // Main content container
          Container(
            padding: const EdgeInsets.only(top: 24.0, bottom: 16.0, left: 16.0, right: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Use minimum space vertically
              crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children horizontally
              children: [
                // Title Text
                const Text(
                  'Для продолжения необходимо\nавторизоваться',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0, // Adjusted font size slightly for better fit
                    fontFamily: 'Jost', // Assuming Jost font based on other screens
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20.0), // Space between text and button
                // Button
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement navigation to login screen
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    // Navigator.pop(context); // Close dialog after navigation
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD6A067), // Match button color
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50), // Full width button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    'Перейти на вход',
                    style: TextStyle(
                      fontSize: 18.0, // Match text style
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Close button in the top right corner
          Positioned(
            top: -10, // Adjust position to be slightly outside/on border
            right: -10, // Adjust position to be slightly outside/on border
            child: GestureDetector(
              onTap: () => Navigator.pop(context), // Close dialog
              child: Container(
                width: 36, // Match size from other dialogs
                height: 36, // Match size
                decoration: BoxDecoration(
                  color: Color(0xFFD6A067), // Match color from other dialogs
                  borderRadius: BorderRadius.circular(8), // Match radius
                  border: Border.all(color: Colors.black, width: 2), // Match border
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.black, // Match color
                    size: 20, // Match size
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