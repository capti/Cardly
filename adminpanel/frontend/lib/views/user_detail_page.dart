import 'package:flutter/material.dart';
import 'user_inventory_page.dart';
import 'user_achievements_page.dart';

class UserDetailPage extends StatelessWidget {
  final Map user;
  const UserDetailPage({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Кнопка назад
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
            // Основной блок пользователя
            Expanded(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 700),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAD7C3),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Аватар, ник, id
                        Column(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                              child: const CircleAvatar(
                                backgroundColor: Color(0xFFEAD7C3),
                                child: Icon(
                                  Icons.person_outline,
                                  size: 80.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              user['username'],
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              user['id'],
                              style: const TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Карточки
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(user['cards'].length, (i) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: _UserCard(),
                          )),
                        ),
                        const SizedBox(height: 20),
                        // Достижения
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => UserAchievementsPage(user: user),
                                  ),
                                );
                              },
                              child: Container(
                                width: 400,
                                padding: const EdgeInsets.fromLTRB(40, 10, 20, 12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD6A067),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: List.generate(4, (i) => Image.asset(
                                        'assets/icons/достижение.png',
                                        width: 59,
                                        height: 59,
                                      )),
                                    ),
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Достижения',
                                        style: TextStyle(fontSize: 15, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        // Ссылка на инвентарь
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UserInventoryPage(user: user),
                                ),
                              );
                            },
                            child: const Text('Посмотреть инвентарь>', style: TextStyle(color: Colors.black, fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Кнопка заблокировать
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: SizedBox(
                width: 340,
                height: 64,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD6A067),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Пользователь заблокирован',
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
                  child: const Text('Заблокировать'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 74,
      height: 112,
      child: AspectRatio(
        aspectRatio: 3/4,
        child: Stack(
          children: [
            // Внешняя тонкая черная рамка
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 2),
              ),
            ),
            // Прослойка цвета карточки
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD6A067),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
            // Внутренняя тонкая черная рамка
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black, width: 2),
                ),
              ),
            ),
            // Основная карточка с отделением редкости
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6A067),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 3,
                    color: Colors.black,
                  ),
                  Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD6A067),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(4, (i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Image.asset(
                          'assets/icons/редкость.png',
                          height: 10,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 