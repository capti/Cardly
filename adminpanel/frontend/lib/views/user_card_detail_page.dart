import 'package:flutter/material.dart';

class UserCardDetailPage extends StatelessWidget {
  final int cardIndex;
  const UserCardDetailPage({required this.cardIndex, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Кнопка назад
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 32),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD6A067),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_back, size: 32, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Основной блок детального просмотра карты
            Expanded(
              child: Center(
                child: Container(
                  width: 600,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7E5CF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Большая карточка
                      Center(
                        child: Container(
                          width: 260,
                          height: 380,
                          child: _UserCardLarge(),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Кнопка удалить
                      SizedBox(
                        width: 320,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD6A067),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Карточка удалена',
                                  style: TextStyle(color: Colors.black),
                                ),
                                duration: const Duration(seconds: 3),
                                backgroundColor: Color(0xFFF7E5CF),
                                behavior: SnackBarBehavior.floating,
                                margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            );
                          },
                          child: const Text('Удалить карточку'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserCardLarge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Заглушки для данных
    final String name = 'Название карты';
    final String description = 'Описание этой карточки. Здесь может быть любой текст.';
    final String type = 'Тип';
    final int rarity = 4;

    return Container(
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
                    fontSize: 14,
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
                ),
                child: const Center(
                  child: Text(
                    'Здесь могла бы быть картинка',
                    style: TextStyle(fontSize: 18, color: Colors.black45),
                    textAlign: TextAlign.center,
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
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Expanded(
              flex: 5, // 5%
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
                        fontSize: 14,
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
    );
  }
} 