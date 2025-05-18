import 'package:flutter/material.dart';
import 'user_card_detail_page.dart';

class UserInventoryPage extends StatelessWidget {
  final Map user;
  const UserInventoryPage({required this.user, Key? key}) : super(key: key);

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
            // Основной блок инвентаря
            Expanded(
              child: Center(
                child: Container(
                  width: 900,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7E5CF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(32),
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 24,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: 40,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UserCardDetailPage(cardIndex: index),
                                ),
                              );
                            },
                            child: _UserCard(),
                          );
                        },
                      ),
                    ),
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

class _UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 74,
      height: 112,
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
            // Основная карточка с отделением редкости
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6A067),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 3,
                    color: Colors.black,
                  ),
                  Container(
                    height: 20,
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
                          height: 10,
                        ),
                      )),
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