import 'package:flutter/material.dart';

class CardDetailScreen extends StatelessWidget {
  final int cardIndex;
  final bool showExchangeButton;

  const CardDetailScreen({Key? key, required this.cardIndex, this.showExchangeButton = false}) : super(key: key);

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
    final data = (cardIndex < cardData.length) ? cardData[cardIndex] : cardData[0];
    final String name = data['name']!;
    final String description = data['desc']!;
    final String type = data['type']!;
    final int rarity = int.tryParse(data['rarity'] ?? '0') ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E3),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD6A067),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.black, size: 32),
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
                            // Здесь был Image.asset, теперь просто пустой контейнер-заглушка
                            child: const Center(
                              child: Text(
                                'Нет изображения',
                                style: TextStyle(color: Colors.black45, fontSize: 16),
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
                              style: const TextStyle(fontSize: 17, color: Colors.black),
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
              child: showExchangeButton
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
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  )
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
                          onPressed: () {},
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Разобрать',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
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
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
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
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Обменять',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
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
} 