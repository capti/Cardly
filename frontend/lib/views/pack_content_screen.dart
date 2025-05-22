import 'package:flutter/material.dart';
import 'shop_screen.dart';
import 'inventory_screen.dart';

class PackContentScreen extends StatelessWidget {
  final String setName;
  const PackContentScreen({super.key, required this.setName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF6EF),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Выпавшие карты:', style: TextStyle(color: Colors.black, fontFamily: 'Jost')),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 80 / 120,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return Container(
                    width: 80.0,
                    height: 120.0,
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
                        // Основная карточка
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
                                      child: const Center(
                                        child: Text(
                                          'Нет изображения',
                                          style: TextStyle(color: Colors.black45, fontSize: 12, fontFamily: 'Jost'),
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
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const ShopScreen()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6A067),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text('Вернуться в магазин', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Roboto')),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const InventoryScreen()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6A067),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text('Перейти в инвентарь', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Roboto')),
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 