import 'package:flutter/material.dart';
import 'package:adminpanel/models/user.dart';
import 'package:adminpanel/controllers/user_controller.dart';

class UserAchievementsPage extends StatelessWidget {
  final User user;
  const UserAchievementsPage({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final achievements = user.achievements;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(), // Можно добавить свою навигацию
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Кнопка назад как в user_detail_page
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 32),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD6A067),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_back, size: 32, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Основной блок достижений
            Expanded(
              child: Center(
                child: Container(
                  width: 700,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7E5CF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListView.separated(
                    itemCount: achievements.length,
                    separatorBuilder: (context, i) => const SizedBox(height: 16),
                    itemBuilder: (context, i) {
                      final ach = achievements[i];
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFD6A067),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        child: Row(
                          children: [
                            Image.asset('assets/icons/достижение.png', width: 48, height: 48),
                            const SizedBox(width: 32),
                            Expanded(
                              child: Text(
                                ach.name,
                                style: const TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              width: 130,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF7E5CF),
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                        'Достижение отменено',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      duration: const Duration(seconds: 3),
                                      backgroundColor: Color(0xFFF7E5CF),
                                      behavior: SnackBarBehavior.floating,
                                      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Отменить'),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 