import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';

class ShopCoinDetailsScreen extends StatefulWidget {
  final String coinName;
  
  const ShopCoinDetailsScreen({
    super.key,
    required this.coinName,
  });

  @override
  State<ShopCoinDetailsScreen> createState() => _ShopCoinDetailsScreenState();
}

class _ShopCoinDetailsScreenState extends State<ShopCoinDetailsScreen> {
  int _currentIndex = 2; // Индекс вкладки "Магазин" в нижней навигации
  
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
          child: const Icon(
            Icons.person_outline,
            color: Colors.black,
          ),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: const Color(0xFFEDD6B0),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                '1000',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 6.0),
              Icon(
                Icons.monetization_on,
                color: Colors.amber,
                size: 20.0,
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
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
                color: const Color(0xFFEDD6B0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const ShopScreen()),
                      );
                    },
                    child: Text(
                      'Наборы',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD6A067),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Монеты',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Основное содержимое - детали монеты
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEDD6B0),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10.0),
                          // Превью монеты
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD6A067),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                widget.coinName,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Вы купили ${widget.coinName}')),
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
                      top: 8.0,
                      right: 8.0,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
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