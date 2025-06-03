import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';
import 'inventory_screen.dart';
import 'profile_screen.dart';
import '../utils/auth_utils.dart';
import '../services/analytics_service.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({super.key});

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  bool _showCategories = false;
  int _currentIndex = 0;
  final List<String> _categories = ['Категория 1', 'Категория 2', 'Категория 3', 'Категория 4'];
  String _selectedCategory = 'Выберите категорию';

  @override
  void initState() {
    super.initState();
    AnalyticsService.trackScreenView('create_card_screen');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!AuthUtils.checkGuestAccess(context, 'create_card_screen')) {
        Navigator.of(context).pop();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
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
                if (AuthUtils.checkGuestAccess(context, 'profile_screen')) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
                }
              },
              child: Image.asset('assets/icons/профиль.png', height: 22),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/уведомления.png',
              height: 36,
              color: Colors.black,
            ),
            onPressed: null,
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
                        color: const Color(0xFFEAD7C3),
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
                              fontFamily: 'Jost',
                            ),
                          ),
                          Icon(
                            _showCategories ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Основное содержимое
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildCardTemplate(),
                
                if (_showCategories)
                  Positioned(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAD7C3).withOpacity(0.95),
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
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: null,
    );
  }
  
  Widget _buildCardTemplate() {
    return Container(
      width: 300,
      height: 450,
      decoration: BoxDecoration(
        color: const Color(0xFFD6A067),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.black, width: 3),
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Container(),
            ),
            Container(
              height: 3,
              color: Colors.black,
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCategoryItem(String category) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategory = category;
          _showCategories = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          category,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontFamily: 'Jost',
          ),
        ),
      ),
    );
  }
} 