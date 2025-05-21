import 'package:flutter/material.dart';
import '../models/achievement_model.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: const Color(0xFFFBF6EF), // Бежевый фон
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
                      borderRadius: BorderRadius.circular(10.0),
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
            // Achievements list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: achievements.length,
                itemBuilder: (context, index) {
                  final achievement = achievements[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    color: const Color(0xFFEAD7C3),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          // Achievement icon using asset
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              achievement.iconPath,
                              width: 40,
                              height: 40,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Achievement details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  achievement.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  achievement.requirement,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
