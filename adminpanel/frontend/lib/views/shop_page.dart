import 'package:flutter/material.dart';
import 'package:adminpanel/views/widgets/navbar.dart';
import 'package:adminpanel/views/shop_offer_create_page.dart';
import 'package:adminpanel/views/shop_coins_page.dart';
import 'package:adminpanel/views/shop_pack_create_page.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Заглушки для наборов
    final packs = List.generate(4, (i) => {
      'name': 'Набор ${i + 1}',
      'price': 100 * (i + 1),
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: const NavBar(active: 'Магазин', showBack: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ShopOfferCreatePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE2A86F),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    elevation: 0,
                  ),
                  child: const Text('Создать предложение', style: TextStyle(fontSize: 15)),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ShopPackCreatePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE2A86F),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    elevation: 0,
                  ),
                  child: const Text('Создать набор карт', style: TextStyle(fontSize: 15)),
                ),
                const Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const ShopCoinsPage()),
                        );
                      },
                      child: Row(
                        children: const [
                          Text('Монеты', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          Icon(Icons.arrow_forward, size: 22),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 32,
                crossAxisSpacing: 32,
                children: [
                  ...packs.map((pack) => _PackCard(
                    name: pack['name'] as String,
                    price: pack['price'] as int,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PackCard extends StatelessWidget {
  final String name;
  final int price;
  const _PackCard({required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7E5CF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFE2A86F),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            const Text('Цена', style: TextStyle(fontSize: 13)),
            Text('$price', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Набор удалён',
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
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE2A86F),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                elevation: 0,
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              child: const Text('Удалить'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE2A86F),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                elevation: 0,
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              child: const Text('Изменить'),
            ),
          ],
        ),
      ),
    );
  }
} 