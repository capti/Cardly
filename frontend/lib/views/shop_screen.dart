import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'search_players_screen.dart';
import 'inventory_screen.dart';
import 'pack_content_screen.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;
  
  final List<String> _sets = [
    'Название набора 1',
    'Название набора 2',
    'Название набора 3',
    'Название набора 4',
  ];
  
  final List<String> _coins = [
    'Ценник 1',
    'Ценник 2',
  ];
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: _selectedTab);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showSetDetails(String setName) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 55.0, left: 16.0, right: 16.0, bottom: 16.0),
                    child: Column(
                      children: [
                        Container(
                          height: 120.0,
                          width: 321.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD6A067),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              setName,
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
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InventoryScreen(
                                    collectionName: setName,
                                    isFromShop: true,
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
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PackContentScreen(
                                    setName: setName,
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
    );
  }

  void _showCoinDetails(String coinName) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 96.0, left: 16.0, right: 16.0, bottom: 16.0),
                    child: Column(
                      children: [
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
                          coinName,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jost',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 60.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              final overlay = Overlay.of(context);
                              final overlayEntry = OverlayEntry(
                                builder: (context) => Positioned(
                                  top: 40,
                                  left: 16,
                                  right: 16,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEAD7C3),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.18),
                                            blurRadius: 8,
                                            offset: const Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 5),
                                      child: const Center(
                                        child: Text(
                                          'Монеты успешно приобретены',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                              overlay.insert(overlayEntry);
                              Future.delayed(const Duration(seconds: 3), () {
                                overlayEntry.remove();
                              });
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
    );
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
                labelStyle: TextStyle(fontFamily: 'Jost'),
                unselectedLabelStyle: TextStyle(fontFamily: 'Jost'),
                onTap: (index) {
                  setState(() {
                    _selectedTab = index;
                  });
                },
              ),
            ),
          ),
          
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSetsTab(),
                _buildCoinsTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: null,
    );
  }
  
  Widget _buildSetsTab() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 16.0),
      itemCount: _sets.length,
      separatorBuilder: (context, index) => const SizedBox(height: 30.0),
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () => _showSetDetails(_sets[index]),
              child: Container(
                width: 321.0,
                height: 120.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6A067),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 7.0),
            Text(
              _sets[index],
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Jost',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
  
  Widget _buildCoinsTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 150 / 175,
        ),
        itemCount: _coins.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () => _showCoinDetails(_coins[index]),
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6A067),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 7.0),
              Text(
                _coins[index],
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Jost',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
} 