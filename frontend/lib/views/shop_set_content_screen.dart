import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';
import 'inventory_screen.dart';
import 'package:flutter/rendering.dart';
import 'card_detail_screen.dart';

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

  Widget _buildCardItem({int index = 0}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardDetailScreen(
              cardIndex: index,
              showExchangeButton: false,
              isFromShop: true,
            ),
          ),
        );
      },
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
            // Основная карточка
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD6A067),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0),
                        ),
                        child: Container(
                          color: const Color(0xFFEAD7C3),
                          child: const Center(
                            child: Text(
                              'Нет изображения',
                              style: TextStyle(color: Colors.black45, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 3,
                      color: Colors.black,
                    ),
                    Container(
                      height: 32,
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
                            height: 14,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 12.0,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return _buildCardItem(index: index);
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