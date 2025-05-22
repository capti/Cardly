import 'package:flutter/material.dart';
import 'shop_set_content_screen.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';
import 'profile_screen.dart';
import 'search_players_screen.dart';
import 'pack_content_screen.dart';

class ShopSetDetailsScreen extends StatefulWidget {
  final String setName;
  
  const ShopSetDetailsScreen({
    super.key,
    required this.setName,
  });

  @override
  State<ShopSetDetailsScreen> createState() => _ShopSetDetailsScreenState();
}

class _ShopSetDetailsScreenState extends State<ShopSetDetailsScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 2; // Индекс вкладки "Магазин" в нижней навигации
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF), // Бежевый фон
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF6EF),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            width: 40.0,
            height: 40.0,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              child: Image.asset('assets/icons/профиль.png', height: 22),
            ),
          ),
        ),
        title: null,
        centerTitle: true,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xFFEAD7C3),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '1000',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Jost',
                  ),
                ),
                SizedBox(width: 6.0),
                Image.asset('assets/icons/монеты.png', height: 20),
              ],
            ),
          ),
          IconButton(
            icon: Image.asset('assets/icons/поиск.png', height: 32),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const SearchPlayersModal(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Вкладки "Наборы" и "Монеты"
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFEAD7C3),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TabBar(
                controller: _tabController,
                dividerColor: Colors.transparent,
                indicator: const BoxDecoration(
                  color: Color(0xFFD6A067),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: 'Наборы'),
                  Tab(text: 'Монеты'),
                ],
                labelStyle: TextStyle(fontFamily: 'Roboto'),
                unselectedLabelStyle: TextStyle(fontFamily: 'Roboto'),
                onTap: (index) {
                  if (index == 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ShopScreen()),
                    );
                  }
                },
              ),
            ),
          ),
          
          // Основное содержимое - детали набора
          Expanded(
            child: Center(
              child: SizedBox(
                width: 360.0,
                height: 492.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAD7C3),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black, width: 3),
                  ),
                  child: Stack(
                    children: [
                      // Содержимое карточки набора
                      Padding(
                        padding: const EdgeInsets.only(top: 55.0, left: 16.0, right: 16.0, bottom: 16.0),
                        child: Column(
                          children: [
                            // Превью набора
                            Container(
                              height: 120.0,
                              width: 321.0,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD6A067),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            // Название и цена
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.setName,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Jost',
                                  ),
                                ),
                                const Text(
                                  'Цена',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Jost',
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 70.0),
                            
                            // Кнопка просмотра содержимого
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShopSetContentScreen(setName: widget.setName),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD6A067),
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text(
                                  'Посмотреть содержимое',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 12.0),
                            
                            // Кнопка покупки
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PackContentScreen(
                                        setName: widget.setName,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD6A067),
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text(
                                  'Купить',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Кнопка закрытия
                      Positioned(
                        top: -1,
                        right: -1,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 48.0,
                            height: 48.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9A76A),
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                              ),
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 32.0,
                              weight: 900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Нижняя навигационная панель
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFD6A067),
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                if (index != _currentIndex) {
                  setState(() {
                    _currentIndex = index;
                  });
                  
                  // Навигация в зависимости от выбранного индекса
                  switch (index) {
                    case 0: // Главное меню
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                        (route) => false,
                      );
                      break;
                    case 2: // Магазин
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const ShopScreen()),
                        (route) => false,
                      );
                      break;
                    case 3: // Обменчик
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const ExchangesScreen()),
                        (route) => false,
                      );
                      break;
                  }
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