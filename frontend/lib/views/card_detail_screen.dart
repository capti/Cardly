import 'package:flutter/material.dart';
import '../models/card_model.dart';
import 'create_exchange_screen.dart';
import '../services/api_service.dart';
import '../utils/error_formatter.dart';

class CardDetailScreen extends StatefulWidget {
  final CardModel card;
  final int cardIndex;
  final bool showExchangeButton;
  final bool isFromShop;
  final bool showFavoriteButton;

  const CardDetailScreen({
    Key? key,
    required this.card,
    required this.cardIndex,
    this.showExchangeButton = false,
    this.isFromShop = false,
    this.showFavoriteButton = true,
  }) : super(key: key);

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.card.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.card.imageURL),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.card.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Редкость: ${widget.card.rarity}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.card.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0, left: 16.0, right: 16.0, top: 8.0),
              child: widget.showExchangeButton
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6A067),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Предложить обмен',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
                    ),
                  )
                : widget.isFromShop
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD6A067),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            ),
                            onPressed: _disassembleCard,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Разобрать',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
                                    ),
                                    SizedBox(width: 6),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '150',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Roboto',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 4),
                                    Image.asset(
                                      'assets/icons/монеты.png',
                                      height: 18,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD6A067),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateExchangeScreen(
                                    cardId: widget.cardIndex,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Обменять',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _disassembleCard() async {
    try {
      final coinsReceived = await ApiService().disassembleCard(widget.card.card_ID);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Получено монет: $coinsReceived')),
      );
      Navigator.pop(context); // Возвращаемся на предыдущий экран
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ErrorFormatter.formatError(e))),
      );
    }
  }
} 