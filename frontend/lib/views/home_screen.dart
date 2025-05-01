import 'package:flutter/material.dart';
import './inventory_screen.dart';
import './shop_screen.dart';
import './exchange_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _showPlaceholderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFF4E3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: const Text(
            'Будет реализовано в будущем',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDEB37D),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  child: Text(
                    'Закрыть',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _getScreenByIndex(int index) {
    switch (index) {
      case 0:
        return _buildMainContent();
      case 1:
        return const InventoryScreen();
      case 2:
        return const ShopScreen();
      case 3:
        return const ExchangeScreen();
      default:
        return _buildMainContent();
    }
  }

  Widget _buildMainContent() {
    return Container(
      color: const Color(0xFFFFF4E3),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: Text(
                    'Коллекции',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDD6B0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _showPlaceholderDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDEB37D),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Создай свою уникальную карточку',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _showPlaceholderDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDEB37D),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/icons/квесты.png',
                              height: 24,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 4.0),
                            const Text(
                              'Квесты',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _showPlaceholderDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDEB37D),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/icons/новости.png',
                              height: 24,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 4.0),
                            const Text(
                              'Новости',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4E3),
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: IconButton(
            icon: Image.asset(
              'assets/icons/профиль.png',
              height: 24,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/поиск.png',
              height: 24,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(
              'assets/icons/уведомления.png',
              height: 24,
              color: Colors.black,
            ),
            onPressed: null,
          ),
        ],
      ),
      body: _getScreenByIndex(_currentIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFDEB37D),
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 4.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedIconTheme: const IconThemeData(
            size: 28,
          ),
          unselectedIconTheme: const IconThemeData(
            size: 24,
          ),
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 10,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/главная.png', height: 24),
              activeIcon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDD6B0),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Image.asset('assets/icons/главная.png', height: 24),
              ),
              label: 'Гл.меню',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/Инвентарь.png', height: 24),
              activeIcon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDD6B0),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Image.asset('assets/icons/Инвентарь.png', height: 24),
              ),
              label: 'Инвентарь',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/магазин.png', height: 24),
              activeIcon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDD6B0),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Image.asset('assets/icons/магазин.png', height: 24),
              ),
              label: 'Магазин',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/обменник.png', height: 24),
              activeIcon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDD6B0),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Image.asset('assets/icons/обменник.png', height: 24),
              ),
              label: 'Обменник',
            ),
          ],
        ),
      ),
    );
  }
}