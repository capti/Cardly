import 'package:flutter/material.dart';
import 'exchange_details_screen.dart';
import 'create_exchange_screen.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'inventory_screen.dart';
import 'profile_screen.dart';

class ExchangesScreen extends StatefulWidget {
  const ExchangesScreen({super.key});

  @override
  State<ExchangesScreen> createState() => _ExchangesScreenState();
}

class _ExchangesScreenState extends State<ExchangesScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 3;
  late TabController _tabController;
  String _sortOption = 'По дате';
  bool _showSortOptions = false;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: Container(
          padding: const EdgeInsets.all(8.0),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFEDD6B0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black,
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
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: 'Обмен'),
                Tab(text: 'Мои обмены'),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateExchangeScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD6A067),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Создать обмен',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6.0),
                        Container(
                          width: 20.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                          child: const Icon(Icons.add, size: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
                
                Container(
 
                  child: IconButton(
                    icon: Image.asset('assets/icons/поиск.png', height: 32),
                    onPressed: () {
                    },
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _showSortOptions = !_showSortOptions;
                    });
                  },
                  child: Row(
                    children: [
                      const Text(
                        'Сортировка',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Icon(
                        _showSortOptions ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                
                if (_showSortOptions)
                  Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDD6B0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _sortOption = 'По дате';
                              _showSortOptions = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'По дате',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: _sortOption == 'По дате' ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
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
                      ],
                    ),
                  ),
              ],
            ),
          ),
          
          const SizedBox(height: 8.0),
          
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildExchangesTab(),
                _buildMyExchangesTab(),
              ],
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
  
  Widget _buildExchangesTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: 5, 
      itemBuilder: (context, index) {
        return _buildCardExchangeItem();
      },
    );
  }
  
  Widget _buildMyExchangesTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: 3,
      itemBuilder: (context, index) {
        return _buildCardExchangeItem();
      },
    );
  }
  
  Widget _buildCardExchangeItem() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ExchangeDetailsScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFEDD6B0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Container(
              width: 60.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: const Color(0xFFD6A067),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.black, width: 1),
              ),
            ),
            
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.sync_alt, size: 24.0),
                ],
              ),
            ),
            
            Stack(
              children: [
                Container(
                  width: 60.0,
                  height: 80.0,
                  margin: const EdgeInsets.only(top: 4.0, left: 4.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6A067),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                ),
                Container(
                  width: 60.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6A067),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum ExchangeStatus {
  pending,
  waiting,
  approved,
  rejected,
}

class ExchangeItem {
  final String date;
  final ExchangeStatus status;
  final int fromCards;
  final int toCards;
  final String nickname;
  
  ExchangeItem({
    required this.date,
    required this.status,
    required this.fromCards,
    required this.toCards,
    required this.nickname,
  });
} 