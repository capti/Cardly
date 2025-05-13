import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';
import 'inventory_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E3), // Бежевый фон
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4E3),
        elevation: 0,
        title: const Text(
          'Профиль игрока',
          style: TextStyle(
            color: Colors.black45,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
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
                size: 22.0,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  );
                },
                child: Image.asset(
                  'assets/icons/настройки.png',
                  color: Colors.black,
                  height: 22.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          
          // Аватар пользователя
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person_outline,
                size: 60.0,
                color: Colors.black,
              ),
            ),
          ),
          
          const SizedBox(height: 12.0),
          
          // Имя пользователя
          const Text(
            'Ник',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 4.0),
          
          // ID пользователя
          const Text(
            '######',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black54,
            ),
          ),
          
          const SizedBox(height: 20.0),
          
          // Коллекция карточек (5 карточек в ряд)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                5,
                (index) => _buildCard(),
              ),
            ),
          ),
          
          const SizedBox(height: 20.0),
          
          // Достижения
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFD6A067),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAchievement(),
                _buildAchievement(),
                _buildAchievement(),
                _buildAchievement(),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Все достижения →',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 40.0),
          
          // Статистика
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                // Собрано карт
                Row(
                  children: const [
                    Text(
                      'Собрано карт: ',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '****',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8.0),
                
                // Собрано коллекций
                Row(
                  children: const [
                    Text(
                      'Собрано коллекций: ',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '***',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const Spacer(),
          
          // Нижняя навигационная панель
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFD6A067),
            ),
            child: BottomNavigationBar(
              currentIndex: 0,
              onTap: (index) {
                switch (index) {
                  case 0:
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (route) => false,
                    );
                    break;
                  case 1:
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const InventoryScreen()),
                      (route) => false,
                    );
                    break;
                  case 2:
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const ShopScreen()),
                      (route) => false,
                    );
                    break;
                  case 3:
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const ExchangesScreen()),
                      (route) => false,
                    );
                    break;
                }
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black54,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/главная.png', height: 24),
                  label: 'Гл.меню',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/Инвентарь.png', height: 24),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/магазин.png', height: 24),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/обменник.png', height: 24),
                  label: '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Карточка в профиле
  Widget _buildCard() {
    return Container(
      width: 60.0,
      height: 84.0,
      decoration: BoxDecoration(
        color: const Color(0xFFD6A067),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
              decoration: const BoxDecoration(
                color: Color(0xFFEDD6B0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
            ),
          ),
          Container(
            height: 24.0,
            margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
            decoration: const BoxDecoration(
              color: Color(0xFFEDD6B0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(4.0),
                bottomRight: Radius.circular(4.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Иконка достижения
  Widget _buildAchievement() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: const [
          Icon(
            Icons.emoji_events_outlined,
            size: 24.0,
          ),
          Icon(
            Icons.star_border,
            size: 16.0,
          ),
        ],
      ),
    );
  }
} 