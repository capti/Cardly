import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';
import 'profile_screen.dart';
import 'search_players_screen.dart';

class ShopCoinDetailsScreen extends StatefulWidget {
  final String coinName;
  
  const ShopCoinDetailsScreen({
    super.key,
    required this.coinName,
  });

  @override
  State<ShopCoinDetailsScreen> createState() => _ShopCoinDetailsScreenState();
}

class _ShopCoinDetailsScreenState extends State<ShopCoinDetailsScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 2; // Индекс вкладки "Магазин" в нижней навигации
  late TabController _tabController;
  final List<String> _coins = [
    'Ценник 1',
    'Ценник 2',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4E3),
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
                indicator: const BoxDecoration(
                  color: Color(0xFFD6A067),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 3.0,
                    ),
                  ),
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: 'Наборы'),
                  Tab(text: 'Монеты'),
                ],
                onTap: (index) {
                  if (index == 0) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ShopScreen()),
                    );
                  }
                },
              ),
            ),
          ),
          // Основное содержимое - детали монеты
          Expanded(
            child: Center(
              child: SizedBox(
                width: 360.0,
                height: 492.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDD6B0),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black, width: 3),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 96.0, left: 16.0, right: 16.0, bottom: 16.0),
                        child: Column(
                          children: [
                            // Превью монеты
                            Center(
                              child: Container(
                                height: 150.0,
                                width: 150.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD6A067),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 7.0),
                            Text(
                              widget.coinName,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10.0),
                            // Название и цена
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.coinName,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'Цена',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            // Кнопка покупки
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      Future.delayed(const Duration(seconds: 3), () {
                                        Navigator.of(context).pop();
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => const ShopScreen()),
                                        );
                                      });
                                      return Dialog(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(height: 50),
                                            Container(
                                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFEDD6B0),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: const Text(
                                                'Набор успешно приобретен',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
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
                  switch (index) {
                    case 0:
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
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
                  label: 'Главная',
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
} 