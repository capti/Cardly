import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';
import 'profile_screen.dart';
import 'card_detail_screen.dart';
import 'search_players_screen.dart';

class InventoryScreen extends StatefulWidget {
  final bool isOtherUser;
  final String? playerName;
  final String? playerId;
  final String? collectionName;

  const InventoryScreen({
    super.key,
    this.isOtherUser = false,
    this.playerName,
    this.playerId,
    this.collectionName,
  });

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
      backgroundColor: const Color(0xFFFBF6EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF6EF),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: widget.isOtherUser
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFD6A067),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 29.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Инвентарь ${widget.playerName}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      fontFamily: 'Jost',
                    ),
                  ),
                ],
              )
            : widget.collectionName != null
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFD6A067),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20.0),
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 29.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Коллекция ${widget.collectionName}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          fontFamily: 'Jost',
                        ),
                      ),
                    ],
                  )
                : Padding(
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
        centerTitle: false,
        actions: widget.isOtherUser ? null : widget.collectionName != null ? null : [
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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.collectionName == null) // Only show sorting if not viewing a collection
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
                                  fontFamily: 'Jost',
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
                  color: const Color(0xFFEAD7C3),
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
                            fontFamily: 'Jost',
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
                            fontFamily: 'Jost',
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
      bottomNavigationBar: widget.isOtherUser
          ? null
          : Container(
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                        break;
                      case 2:
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const ShopScreen()),
                        );
                        break;
                      case 3:
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const ExchangesScreen()),
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
                  fontFamily: 'Jost',
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 11,
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
    );
  }
  
  Widget _buildCardItem({int index = 0}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardDetailScreen(
              cardIndex: index,
              showExchangeButton: widget.isOtherUser,
              showFavoriteButton: !widget.isOtherUser,
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
                              style: TextStyle(color: Colors.black45, fontSize: 12, fontFamily: 'Jost'),
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
} 