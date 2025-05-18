import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';
import 'inventory_screen.dart';
import 'package:flutter/rendering.dart';

class ShopSetContentScreen extends StatefulWidget {
  final String setName;
  
  const ShopSetContentScreen({
    super.key,
    required this.setName,
  });

  @override
  State<ShopSetContentScreen> createState() => _ShopSetContentScreenState();
}

class _ShopSetContentScreenState extends State<ShopSetContentScreen> {
  void _handleNavigation(int index) {
    if (index != 2) { // Если нажата не иконка магазина
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
        case 3:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ExchangesScreen()),
            (route) => false,
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E3),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 28.0),
          const Text(
            'В наборе содержится:',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28.0),
          // Сетка карточек
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 80 / 120,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return Container(
                    width: 80.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD6A067),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Stack(
                      children: [
                        // Основная рамка карты
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                        // Внутренняя рамка карты
                        Positioned(
                          top: 5,
                          left: 5,
                          right: 5,
                          bottom: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                        ),
                        // Линия разделения карты
                        Positioned(
                          left: 5,
                          right: 5,
                          bottom: 40,
                          child: Container(
                            height: 1,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Нижняя навигационная панель
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFD6A067),
              border: Border(
                top: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: 2,
              onTap: _handleNavigation,
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
                fontSize: 11,
              ),
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/главная.png', height: 24),
                  activeIcon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDD6B0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset('assets/icons/главная.png', height: 24),
                  ),
                  label: 'Главная',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/Инвентарь.png', height: 24),
                  activeIcon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDD6B0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset('assets/icons/Инвентарь.png', height: 24),
                  ),
                  label: 'Инвентарь',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/магазин.png', height: 24),
                  activeIcon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDD6B0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset('assets/icons/магазин.png', height: 24),
                  ),
                  label: 'Магазин',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/обменник.png', height: 24),
                  activeIcon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDD6B0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset('assets/icons/обменник.png', height: 24),
                  ),
                  label: 'Обменник',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 