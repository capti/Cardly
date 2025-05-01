import 'package:flutter/material.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _sortValue = 'По дате';

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
        title: const Text(
          'Обменник', 
          style: TextStyle(color: Colors.black)
          ),
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 40,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Stack(
              children: [
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAD2B7),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _tabController.index = 0),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: _tabController.index == 0
                                ? const Color(0xFFD6A574)
                                : Colors.transparent,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(14),
                              bottomLeft: Radius.circular(14),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: const Text(
                                  'Обмен',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (_tabController.index == 0)
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Center(
                                    child: Container(
                                      width: 32,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _tabController.index = 1),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: _tabController.index == 1
                                ? const Color(0xFFD6A574)
                                : Colors.transparent,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(14),
                              bottomRight: Radius.circular(14),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: const Text(
                                  'Мои обмены',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (_tabController.index == 1)
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Center(
                                    child: Container(
                                      width: 32,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD6A574),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Создать обмен'),
                        SizedBox(width: 8),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.search, 
                    size: 32),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    setState(() {
                      _sortValue = value;
                    });
                  },
                  color: const Color(0xFFEAD2B7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  offset: const Offset(0, 36),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'По дате',
                      child: Text('По дате', 
                      style: TextStyle(fontSize: 20)
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'По редкости',
                      child: Text(
                        'По  редкости', 
                        style: TextStyle(
                          fontSize: 20)
                          ),
                    ),
                  ],
                  child: Row(
                    children: [
                      const Text(
                        'Сортировка',
                        style: TextStyle(
                          color: Colors.black, 
                          fontSize: 20, 
                          fontWeight: FontWeight.w400
                          ),
                      ),
                      const Icon(
                        Icons.arrow_drop_down, 
                        color: Colors.black
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _tabController.index,
              children: [
                _buildExchangeList(),
                Center(child: const Text(
                  'Мои обмены', 
                  style: TextStyle(fontSize: 20))
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEAD2B7),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _cardIcon(),
              _exchangeArrow(index),
              _cardIcon(stack: index % 2 == 1),
            ],
          ),
        );
      },
    );
  }

  Widget _cardIcon({bool stack = false}) {
    if (stack) {
      return Stack(
        alignment: Alignment.centerRight,
        children: [
          Positioned(
            right: 8,
            child: Image.asset(
              'assets/icons/карточка.png',
              width: 36,
              height: 48,
              fit: BoxFit.contain,
            ),
          ),
          Image.asset(
            'assets/icons/карточка.png',
            width: 36,
            height: 48,
            fit: BoxFit.contain,
          ),
        ],
      );
    } else {
      return Image.asset(
        'assets/icons/карточка.png',
        width: 36,
        height: 48,
        fit: BoxFit.contain,
      );
    }
  }

  Widget _exchangeArrow(int index) {
    return const Icon(
      Icons.compare_arrows, 
    size: 36, 
    color: Colors.black
    );
  }
} 