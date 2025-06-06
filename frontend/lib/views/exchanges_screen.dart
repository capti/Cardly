import 'package:flutter/material.dart';
import 'exchange_details_screen.dart';
import 'create_exchange_screen.dart';
import 'profile_screen.dart';
import 'search_players_screen.dart';
import 'exchange_proposal_screen.dart';
import '../services/api_service.dart';
import '../models/trade_model.dart';
import '../utils/error_formatter.dart';
import '../utils/auth_utils.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../services/analytics_service.dart';

class ExchangesScreen extends StatefulWidget {
  final int? initialTabIndex;
  const ExchangesScreen({super.key, this.initialTabIndex});

  @override
  State<ExchangesScreen> createState() => _ExchangesScreenState();
}

class _ExchangesScreenState extends State<ExchangesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _sortOption = 'По дате';
  bool _showSortOptions = false;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    AnalyticsService.trackScreenView('exchanges_screen');
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTabIndex ?? 0);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController.index == 1) { // Мои обмены
      if (!AuthUtils.checkGuestAccess(context, 'my_exchanges_screen')) {
        _tabController.animateTo(0); // Возвращаемся на вкладку "Обмен"
      }
    }
  }
  
  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF6EF),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Container(
          padding: const EdgeInsets.all(8.0),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
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
                Tab(text: 'Обмен'),
                Tab(text: 'Мои обмены'),
              ],
              labelStyle: TextStyle(fontFamily: 'Jost'),
              unselectedLabelStyle: TextStyle(fontFamily: 'Jost'),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (AuthUtils.checkGuestAccess(context, 'create_exchange_screen')) {
                      AnalyticsService.trackExchange();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CreateExchangeScreen()),
                      );
                    }
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
                            fontFamily: 'Roboto',
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
                    icon: Image.asset('assets/icons/поиск.png', height: 26),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const SearchPlayersModal(),
                      );
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
                          fontFamily: 'Jost',
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
          
          // Sorting options dropdown (Positioned overlay)
                if (_showSortOptions)
            Positioned(
              top: 110, // Approximate position below the Sorting text
              left: 16, // Align with the left padding
              child: Container(
                width: 120.0, // Set a fixed width to match inventory_screen dropdown size
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                  color: const Color(0xFFEAD7C3), // Background color from inventory_screen
                  borderRadius: BorderRadius.circular(10.0), // Border radius from inventory_screen
                  boxShadow: [ // Box shadow from inventory_screen
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
                          _sortOption = 'По дате'; // Option 1
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
                                fontFamily: 'Jost',
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                          _sortOption = 'По редкости'; // Option 2
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
                      ],
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: null,
    );
  }
  
  Widget _buildExchangesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: 5,
      itemBuilder: (context, index) {
        // Alternate between 1 and 3 for demonstration counts
        final myCardCount = (index % 2 == 0) ? 1 : 5;
        final otherUserCardCount = 1; // Modified to always be 1
        // Use dummy data for demonstration in this tab
        final dummyNickname = 'User ${(index % 3) + 1}';
        final dummyExchangeItem = ExchangeItem(
          date: 'N/A', // Dummy date
          status: ExchangeStatus.pending, // Dummy status
          myOfferedCardIds: List.generate(myCardCount, (i) => i + 1), // Dummy IDs
          otherUserOfferedCardIds: List.generate(otherUserCardCount, (i) => i + 11), // Dummy IDs
          nickname: dummyNickname,
        );
        return _buildCardExchangeItem(
          myOfferedCount: myCardCount,
          otherUserOfferedCount: otherUserCardCount,
          otherUserName: dummyNickname,
          exchangeItem: dummyExchangeItem,
          isMyExchange: false,
          showLeftPlus: index == 0, // Show plus only on the left card of the first item
        );
      },
    );
  }
  
  Widget _buildMyExchangesTab() {
    // Using dummy ExchangeItem data for demonstration
    final List<ExchangeItem> myExchanges = [
      ExchangeItem(date: '2023-10-27', status: ExchangeStatus.pending, myOfferedCardIds: [1], otherUserOfferedCardIds: [5], nickname: 'Alex'),
      ExchangeItem(date: '2023-10-26', status: ExchangeStatus.approved, myOfferedCardIds: [2, 3, 4], otherUserOfferedCardIds: [6], nickname: 'Maria'),
      ExchangeItem(date: '2023-10-25', status: ExchangeStatus.rejected, myOfferedCardIds: [7], otherUserOfferedCardIds: [8, 9, 10], nickname: 'Ivan'),
      ExchangeItem(date: '2023-10-24', status: ExchangeStatus.waiting, myOfferedCardIds: [11, 12], otherUserOfferedCardIds: [14], nickname: 'David'), // Modified to prevent stack on right side
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: myExchanges.length,
      itemBuilder: (context, index) {
        final exchange = myExchanges[index];
        return _buildCardExchangeItem(
          myOfferedCount: exchange.myOfferedCardIds.length,
          otherUserOfferedCount: exchange.otherUserOfferedCardIds.length,
          otherUserName: exchange.nickname,
          exchangeItem: exchange,
          isMyExchange: true, // Set to true for this tab
        );
      },
    );
  }
  
  Widget _buildCardExchangeItem({
    int myOfferedCount = 1,
    int otherUserOfferedCount = 1,
    required String otherUserName,
    required ExchangeItem exchangeItem,
    bool isMyExchange = false,
    bool showLeftPlus = false,
  }) {
    // Helper to get status text
    String getStatusText(ExchangeStatus status) {
      switch (status) {
        case ExchangeStatus.pending: return 'Ожидает\nподтверждения';
        case ExchangeStatus.waiting: return 'Ожидает\nдействий';
        case ExchangeStatus.approved: return 'Завершен';
        case ExchangeStatus.rejected: return 'Отклонен';
      }
    }

    return GestureDetector(
      onTap: () {
        if (!isMyExchange) { // If in 'Обмен' tab
          if (showLeftPlus) { // If the left card has a plus icon
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateExchangeScreen(initialExchangeItem: exchangeItem), // Pass the exchangeItem
              ),
            );
          } else { // If in 'Обмен' tab and no plus icon (multiple cards)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExchangeProposalScreen(exchangeItem: exchangeItem), // Navigate to ExchangeProposalScreen
              ),
            );
          }
        } else { // If in 'Мои обмены' tab, show ExchangeDetailsScreen dialog
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
                child: ExchangeDetailsScreen(exchangeItem: exchangeItem),
            );
          },
        );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFEAD7C3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // First card (offered by current user) - Stacked if 2 or more
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                children: [
                  // Offset to align with right card visual (conditional based on tab)
                  SizedBox(height: 24.0), // Always apply height for alignment
                  myOfferedCount >= 2
                      ? Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 16,
                              top: 0,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: AspectRatio(
                                  aspectRatio: 0.7,
                                  child: _buildSingleCardVisual(showPlus: showLeftPlus),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 8,
                              top: 0,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: AspectRatio(
                                  aspectRatio: 0.7,
                                  child: _buildSingleCardVisual(showPlus: showLeftPlus),
                                ),
                              ),
                            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: AspectRatio(
                aspectRatio: 0.7,
                                child: _buildSingleCardVisual(showPlus: showLeftPlus),
                              ),
                            ),
                          ],
                        )
                      : (myOfferedCount == 1
                          ? AspectRatio(
                              aspectRatio: 0.7,
                              child: _buildSingleCardVisual(showPlus: showLeftPlus),
                            )
                          : SizedBox.shrink()),
                ],
              ),
            ),
            
            // Swap icon or Status text
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isMyExchange
                      ? Text(
                          getStatusText(exchangeItem.status),
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: isMyExchange ? 18.0 : 0.0),
                          child: const Icon(Icons.sync_alt, size: 24.0),
                        ),
                ],
              ),
            ),
            
            // Second card(s) block (offered by other user)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2 + (otherUserOfferedCount > 1 ? 16 : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        otherUserName,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4.0),
                    ],
                  ),
                  otherUserOfferedCount >= 2
                  ? Stack(
                          clipBehavior: Clip.none,
                      children: [
                          Positioned(
                            left: 16,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: AspectRatio(
                                aspectRatio: 0.7,
                                  child: _buildSingleCardVisual(showPlus: false), // Always false for right side
                                ),
                              ),
                            ),
                            if (otherUserOfferedCount >= 2)
                          Positioned(
                            left: 8,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: AspectRatio(
                                aspectRatio: 0.7,
                                    child: _buildSingleCardVisual(showPlus: false), // Always false for right side
                              ),
                            ),
                          ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: AspectRatio(
                            aspectRatio: 0.7,
                                child: _buildSingleCardVisual(showPlus: false), // Always false for right side
                          ),
                        ),
                      ],
                    )
                      : (otherUserOfferedCount == 1
                          ? AspectRatio(
                      aspectRatio: 0.7,
                              child: _buildSingleCardVisual(showPlus: false), // Always false for right side
                            )
                          : SizedBox.shrink()),
                ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSingleCardVisual({bool showPlus = false}) {
    return Stack(
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
                    child: Container(
                      color: const Color(0xFFEAD7C3),
                      child: showPlus 
                        ? const Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 32,
                            ),
                          )
                        : const Center(
                        child: Text(
                              'Нет изображения',
                          style: TextStyle(color: Colors.black45, fontSize: 12),
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
    );
  }

  Future<void> _loadTrades() async {
    try {
      setState(() {
        _isLoading = true;
      });
      // Implement the logic to load trades from the API
      // This is a placeholder and should be replaced with actual implementation
      // For example, you can use a Future.delayed to simulate a delay
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = ErrorFormatter.formatError(e);
      });
    }
  }

  Future<void> _acceptTrade(Trade trade) async {
    try {
      await ApiService().acceptTrade(trade.trade_ID);
      AnalyticsService.trackExchangeComplete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Обмен принят')),
      );
      _loadTrades();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ErrorFormatter.formatError(e))),
      );
    }
  }

  Future<void> _rejectTrade(Trade trade) async {
    try {
      await ApiService().rejectTrade(trade.trade_ID);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Обмен отклонен')),
      );
      _loadTrades();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ErrorFormatter.formatError(e))),
      );
    }
  }

  Future<void> _cancelTrade(Trade trade) async {
    try {
      await ApiService().cancelTrade(trade.trade_ID);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Обмен отменен')),
      );
      _loadTrades();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ErrorFormatter.formatError(e))),
      );
    }
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
  final List<int> myOfferedCardIds;
  final List<int> otherUserOfferedCardIds;
  final String nickname;
  
  ExchangeItem({
    required this.date,
    required this.status,
    required this.myOfferedCardIds,
    required this.otherUserOfferedCardIds,
    required this.nickname,
  });
} 