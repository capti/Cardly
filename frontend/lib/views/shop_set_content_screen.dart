import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';

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
  int _currentIndex = 2; // Индекс вкладки "Магазин" в нижней навигации
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E3), // Бежевый фон
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4E3),
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFD6A067),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'В наборе содержатся:',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Column(
        children: [
          // Сетка карточек
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 12, // 12 карточек в сетке (3x4)
                itemBuilder: (context, index) {
                  return _buildCardItem();
                },
              ),
            ),
          ),
          
          // Нижняя навигационная панель
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFD6A067),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
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
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Главная',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.storefront),
                  label: 'Магазин',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Метод построения элемента карточки
  Widget _buildCardItem() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD6A067),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        children: [
          // Верхняя часть карточки
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFD6A067),
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
          ),
          
          // Нижняя часть карточки
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: const Color(0xFFD6A067),
            ),
          ),
        ],
      ),
    );
  }
} 