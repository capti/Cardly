import 'package:flutter/material.dart';
import 'create_exchange_screen.dart';

class CardDetailScreen extends StatefulWidget {
  final int cardIndex;
  final bool showExchangeButton;
  final bool isFromShop;
  final bool showFavoriteButton;

  const CardDetailScreen({
    Key? key, 
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
    // Данные для карточек
    final List<Map<String, String>> cardData = [
      {
        'name': 'Название',
        'desc': 'Описание карточки',
        'type': 'Тип',
        'rarity': '4',
      },
      // ... можно добавить больше заглушек ...
    ];
    final data = (widget.cardIndex < cardData.length) ? cardData[widget.cardIndex] : cardData[0];
    final String name = data['name']!;
    final String description = data['desc']!;
    final String type = data['type']!;
    final int rarity = int.tryParse(data['rarity'] ?? '0') ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFD6A067),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 29.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      width: 340,
                      height: 520,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6A067),
                        borderRadius: BorderRadius.circular(18.0),
                        border: Border.all(color: Colors.black, width: 6),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD6A067),
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(color: Colors.black, width: 3),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 3, // 5%
                              child: Center(
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontFamily: 'Jost',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 36, // 60%
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 3),
                                  color: const Color(0xFFEAD7C3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Нет изображения',
                                    style: TextStyle(color: Colors.black45, fontSize: 16, fontFamily: 'Jost'),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 18, // 30%
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                                child: Text(
                                  description,
                                  style: const TextStyle(fontSize: 17, color: Colors.black, fontFamily: 'Jost'),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3, // 5%
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: List.generate(
                                        rarity,
                                        (index) => Padding(
                                          padding: const EdgeInsets.only(right: 4.0),
                                          child: Image.asset(
                                            'assets/icons/редкость.png',
                                            height: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      type,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontFamily: 'Jost',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                                onPressed: () {
                                  // TODO: Implement logic to disassemble the card and add coins.
                                  // 1. Get the current coin balance.
                                  // 2. Add 150 coins to the balance.
                                  // 3. Update the coin balance in your state management or data source.

                                  // After disassembling, navigate back to the inventory screen.
                                  Navigator.pop(context); // Assumes CardDetailScreen was pushed from InventoryScreen
                                },
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
            Positioned(
              top: 111,
              right: -4,
              child: widget.showFavoriteButton ? InkWell(
                onTap: () {
                  setState(() {
                    isFavorite = !isFavorite;
                    print('isFavorite: $isFavorite');

                    // TODO: Integrate your favorite state management here.
                    // If isFavorite is true, add widget.cardIndex to the user's favorite list.
                    // If isFavorite is false, remove widget.cardIndex from the user's favorite list.
                    // Example (using a hypothetical function saveFavoriteCardId and removeFavoriteCardId):
                    // if (isFavorite) {
                    //   saveFavoriteCardId(widget.cardIndex);
                    // } else {
                    //   removeFavoriteCardId(widget.cardIndex);
                    // }
                  });
                },
                child: SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: Center(
                    child: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: Colors.black,
                      size: 46.0,
                    ),
                  ),
                ),
              ) : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
} 