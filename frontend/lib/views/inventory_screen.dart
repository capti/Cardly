import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';
import 'profile_screen.dart';
import 'card_detail_screen.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  int _currentIndex = 1;
  String _sortOption = 'По редкости';
  bool _showSortOptions = false;
  
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
              color: const Color(0xFFEDD6B0),
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
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _showSortOptions = !_showSortOptions;
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Сортировка:',
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6.0),
                            Icon(
                              _showSortOptions ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 12.0,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return _buildCardItem(index: index);
                  },
                ),
              ),
            ],
          ),
          
          if (_showSortOptions)
            Positioned(
              top: 50,
              left: 16,
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDD6B0),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _sortOption = 'По редкости';
                          _showSortOptions = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'По редкости',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: _sortOption == 'По редкости' ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _sortOption = 'По коллекциям';
                          _showSortOptions = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'По коллекциям',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: _sortOption == 'По коллекциям' ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
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
    );
  }
  
  Widget _buildCardItem({int index = 0}) {
    if (index == 0) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardDetailScreen(cardIndex: index),
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
                          child: Image.asset(
                            'assets/images/chameleon.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
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
    } else if (index == 1) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardDetailScreen(cardIndex: index),
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
                          child: Image.asset(
                            'assets/images/kiwi.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
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
    } else if (index == 2) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardDetailScreen(cardIndex: index),
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
                          child: Image.asset(
                            'assets/images/platypus.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
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
    } else if (index == 3) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardDetailScreen(cardIndex: index),
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
                          child: Image.asset(
                            'assets/images/pantera.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
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
      
    } else if (index == 4) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardDetailScreen(cardIndex: index),
            ),
          );
        },
        child: AspectRatio(
          aspectRatio: 3/4,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black, width: 2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6A067),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
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
                          child: Image.asset(
                            'assets/images/white_bear.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
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
                          children: List.generate(3, (i) => Padding(
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
    }else if (index == 5) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardDetailScreen(cardIndex: index),
            ),
          );
        },
        child: AspectRatio(
          aspectRatio: 3/4,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black, width: 2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6A067),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
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
                          child: Image.asset(
                            'assets/images/camel.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
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
                          children: List.generate(3, (i) => Padding(
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
    } else if (index == 6) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardDetailScreen(cardIndex: index),
            ),
          );
        },
        child: AspectRatio(
          aspectRatio: 3/4,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black, width: 2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6A067),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
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
                          child: Image.asset(
                            'assets/images/zebra.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
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
                          children: List.generate(3, (i) => Padding(
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
    } else if (index == 7) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardDetailScreen(cardIndex: index),
            ),
          );
        },
        child: AspectRatio(
          aspectRatio: 3/4,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black, width: 2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6A067),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
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
                          child: Image.asset(
                            'assets/images/elephant.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
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
                          children: List.generate(3, (i) => Padding(
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
    //};// else {
      //return Container(
        //decoration: BoxDecoration(
         // color: const Color(0xFFD6A067),
        //  borderRadius: BorderRadius.circular(8.0),
        //  border: Border.all(color: Colors.black, width: 2),
      //),
    //);
    }
    return const SizedBox.shrink();
  }
} 