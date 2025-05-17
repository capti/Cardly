import 'package:flutter/material.dart';
import '../models/achievement_model.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual achievements data
    final List<Achievement> achievements = List.generate(
      10,
      (index) => Achievement(
        id: 'achievement_$index',
        title: 'Достижение ${index + 1}',
        description: 'Описание достижения ${index + 1}',
        requirement: 'что нужно для достижения',
        iconPath: 'assets/icons/достижение.png',
        isCompleted: false,
        progress: 0.0,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E3), // Бежевый фон
      body: SafeArea(
        child: Column(
          children: [
            // Back button and title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD6A067),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20.0),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 29.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Достижения',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // ... existing code ...
          ],
        ),
      ),
    );
  }
}
