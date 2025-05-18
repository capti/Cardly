import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';
import 'inventory_screen.dart';
import 'profile_screen.dart';

class CreateExchangeScreen extends StatefulWidget {
  const CreateExchangeScreen({super.key});

  @override
  State<CreateExchangeScreen> createState() => _CreateExchangeScreenState();
}

class _CreateExchangeScreenState extends State<CreateExchangeScreen> {
  int _currentIndex = 3;
  Map<String, dynamic>? selectedTopCard;
  List<Map<String, dynamic>> selectedExchangeCards = [];

  void _showTopCardSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFFFFF4E3),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Выберите вашу карту',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Jost',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: 40,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTopCard = {
                              'id': index,
                              'name': 'Карта $index',
                            };
                          });
                          Navigator.pop(context);
                        },
                        child: _buildCollectionCard(index),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFD6A067),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Создание обмена',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontFamily: 'Jost',
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Заголовок "Ваша карта для обмена"
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'Ваша карта для обмена',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontFamily: 'Jost',
              ),
            ),
          ),
          // Карточка для выбора своей карты (одноразовый выбор)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: selectedTopCard == null
              ? GestureDetector(
                  onTap: _showTopCardSelectionDialog,
                  child: _buildCardPlaceholder(),
                )
              : _buildCollectionCard(
                  selectedTopCard!['id'],
                  onRemove: () {
                    setState(() {
                      selectedTopCard = null;
                    });
                  },
                ),
          ),
          const SizedBox(height: 20.0),
          // Текст для карт обмена
          const Column(
            children: [
              Text(
                'Карта, на которую вы',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontFamily: 'Jost',
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                'готовы произвести обмен',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontFamily: 'Jost',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          // Ряды карточек для обмена (многоразовый выбор)
          Expanded(
            child: _buildExchangeCardsRow(),
          ),
          // Кнопка создания обмена
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: (selectedTopCard == null || selectedExchangeCards.isEmpty) 
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Container(
                          width: 367,
                          height: 61,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDD6B0),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                          child: const Center(
                            child: Text(
                              'Добавьте карточки для обмена',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Jost',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 120,
                          left: 16,
                          right: 16,
                        ),
                        elevation: 0,
                      ),
                    );
                  }
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Container(
                          width: 367,
                          height: 61,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDD6B0),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                          child: const Center(
                            child: Text(
                              'Обмен создан',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Jost',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 200,
                          left: 16,
                          right: 16,
                        ),
                        elevation: 0,
                      ),
                    );
                    
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const ExchangesScreen()),
                      (route) => false,
                    );
                  },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD6A067),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                disabledBackgroundColor: const Color(0xFFD6A067).withOpacity(0.7),
                disabledForegroundColor: Colors.black.withOpacity(0.5),
              ),
              child: const Text(
                'Создать обмен',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Jost',
                ),
              ),
            ),
          ),
          // Нижняя навигация
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
              currentIndex: _currentIndex,
              onTap: (index) {
                if (index != _currentIndex) {
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
                size: 24,
              ),
              unselectedIconTheme: const IconThemeData(
                size: 24,
              ),
              selectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'Jost',
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontFamily: 'Jost',
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

  Widget _buildCollectionCard(int index, {bool isSelected = true, Function()? onRemove}) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xFFD6A067),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
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
              Positioned(
                left: 5,
                right: 5,
                bottom: 30,
                child: Container(
                  height: 1,
                  color: Colors.black,
                ),
              ),
              Center(
                child: Text(
                  'Карта $index',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Jost',
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isSelected && onRemove != null)
          Positioned(
            top: -5,
            right: -5,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4E3),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    size: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCardPlaceholder() {
    return Container(
      width: 80,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFFD6A067),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
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
          Positioned(
            left: 5,
            right: 5,
            bottom: 30,
            child: Container(
              height: 1,
              color: Colors.black,
            ),
          ),
          Center(
            child: Icon(
              Icons.add,
              size: 24,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeCardsRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Первый ряд карточек (максимум 4)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                ...selectedExchangeCards.take(4).map((card) => Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: _buildCollectionCard(
                    card['id'],
                    onRemove: () {
                      setState(() {
                        selectedExchangeCards.remove(card);
                      });
                    },
                  ),
                )).toList(),
                if (selectedExchangeCards.length < 4)
                  GestureDetector(
                    onTap: _showLargeCardSelectionDialog,
                    child: _buildCardPlaceholder(),
                  ),
              ],
            ),
          ),
        ),
        // Второй ряд карточек (максимум 4)
        if (selectedExchangeCards.length >= 4)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...selectedExchangeCards.skip(4).take(4).map((card) => Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: _buildCollectionCard(
                      card['id'],
                      onRemove: () {
                        setState(() {
                          selectedExchangeCards.remove(card);
                        });
                      },
                    ),
                  )).toList(),
                  if (selectedExchangeCards.length < 8)
                    GestureDetector(
                      onTap: _showLargeCardSelectionDialog,
                      child: _buildCardPlaceholder(),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  void _showLargeCardSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFFFFF4E3),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Выберите карту для обмена',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Jost',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: 40,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (selectedExchangeCards.length < 8) {
                            setState(() {
                              selectedExchangeCards.add({
                                'id': index,
                                'name': 'Карта $index',
                              });
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          width: 80,
                          height: 120,
                          child: _buildCollectionCard(index),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 