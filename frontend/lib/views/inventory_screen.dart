import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'card_detail_screen.dart';
import 'search_players_screen.dart';
import '../services/api_service.dart';
import '../models/card_model.dart';
import '../utils/error_formatter.dart';

class InventoryScreen extends StatefulWidget {
  final bool isOtherUser;
  final String? playerName;
  final int? playerId;
  final String? collectionName;
  final bool isFromShop;

  const InventoryScreen({
    super.key,
    this.isOtherUser = false,
    this.playerName,
    this.playerId,
    this.collectionName,
    this.isFromShop = false,
  });

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  late bool _isLoading;
  late List<CardModel> _cards;
  late String _error;
  String _sortBy = 'rarity';

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _cards = [];
    _error = '';
    _loadInventory();
  }

  Future<void> _loadInventory() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final cards = widget.isOtherUser
          ? await ApiService().getOtherProfileInventory(widget.playerId ?? 0)
          : await ApiService().getUserInventory(sortBy: _sortBy);
      
      setState(() {
        _cards = (cards as List).map((item) => CardModel.fromJson(item)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = ErrorFormatter.formatError(e);
      });
    }
  }

  Future<void> _disassembleCard(CardModel card) async {
    try {
      final coinsReceived = await ApiService().disassembleCard(card.card_ID);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Получено монет: $coinsReceived')),
      );
      await _loadInventory(); // Перезагружаем инвентарь
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ErrorFormatter.formatError(e))),
      );
    }
  }

  void _showCardDetails(CardModel card) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardDetailScreen(
          card: card,
          cardIndex: 0,
          showExchangeButton: false,
          isFromShop: false,
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
                        widget.isFromShop 
                            ? 'Содержимое ${widget.collectionName}'
                            : 'Коллекция ${widget.collectionName}',
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
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(child: Text(_error))
              : _cards.isEmpty
                  ? const Center(child: Text('Нет карт'))
                  : GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: _cards.length,
                      itemBuilder: (context, index) {
                        final card = _cards[index];
                        return GestureDetector(
                          onTap: () => _showCardDetails(card),
                          onLongPress: widget.isOtherUser ? null : () => _disassembleCard(card),
                          child: Card(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    card.imageURL,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        card.name,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text('Редкость: ${card.rarity}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
      bottomNavigationBar: null,
    );
  }
} 