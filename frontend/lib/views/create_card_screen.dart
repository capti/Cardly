import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({super.key});

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  bool _showCategories = false;
  int _currentIndex = 0; // Установлено 0 для главного меню
  final List<String> _categories = ['Категория 1', 'Категория 2', 'Категория 3', 'Категория 4'];
  String _selectedCategory = 'Пример категории';
  
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
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: const Icon(
            Icons.person_outline,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Секция выбора категории
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                // Кнопка назад
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFD6A067),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                
                const SizedBox(width: 12.0),
                
                // Поле выбора категории
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showCategories = !_showCategories;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDD6B0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedCategory,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          // Значок стрелки меняется в зависимости от состояния
                          Icon(
                            _showCategories ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, 
                            color: Colors.black
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Основное содержимое - макет карточки или список категорий
          Expanded(
            child: Stack(
              children: [
                // Макет карточки всегда показывается в фоне
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildCardTemplate(),
                ),
                
                // Список категорий показывается поверх, если _showCategories = true
                if (_showCategories)
                  Positioned(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDD6B0).withOpacity(0.95),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _categories.map((category) => _buildCategoryItem(category)).toList(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Кнопка создания
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Логика создания карточки
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
                  'Создать',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                  label: '',
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
  
  // Метод построения шаблона карточки
  Widget _buildCardTemplate() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD6A067),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black, width: 2),
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
                  bottom: BorderSide(color: Colors.black, width: 2),
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
  
  // Метод построения элемента категории
  Widget _buildCategoryItem(String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
          _showCategories = false;
        });
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFD6A067),
          borderRadius: BorderRadius.circular(4.0),
        ),
        alignment: Alignment.center,
        child: Text(
          category,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
} 