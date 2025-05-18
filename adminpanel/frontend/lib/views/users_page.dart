import 'package:flutter/material.dart';
import 'widgets/navbar.dart';
import 'user_detail_page.dart';
import 'package:adminpanel/models/user.dart';
import 'package:adminpanel/controllers/user_controller.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Пример данных пользователей
    final users = List.generate(5, (userIdx) => User(
      userId: userIdx,
      username: 'Ник',
      email: 'email@domain.com',
      password: 'password',
      favorites: const [],
      inventoryCards: const [],
      onChange: const [],
      balance: 0,
      avatarUrl: '',
      achievements: const [],
      favoritesAchievements: const [],
      notifications: const [],
      profileData: ProfileData(),
    ));

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: const NavBar(active: 'Пользователи', showBack: false),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 42),
                // Поиск пользователей
                Container(
                  width: 900,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAD7C3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Image.asset(
                            'assets/icons/поиск.png',
                            width: 32,
                            height: 32,
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Введите ник или id пользователя',
                                hintStyle: TextStyle(
                                  color: Color(0xFF888888),
                                  fontSize: 20,
                                ),
                              ),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 900,
                  child: Column(
                    children: users.map((user) => Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UserDetailPage(user: user),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAD7C3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: _UserRow(user: user),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UserRow extends StatelessWidget {
  final User user;
  const _UserRow({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Аватарка и ник
          Column(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: const CircleAvatar(
                  backgroundColor: Color(0xFFF7E5CF),
                  child: Icon(
                    Icons.person_outline,
                    size: 40.0,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                user.username,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                user.userId.toString(),
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(width: 132),
          // Карточки пользователя
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(user.inventoryCards.length, (i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _UserCard(),
              )),
            ),
          ),
        ],
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