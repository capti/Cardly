import 'package:flutter/material.dart';
import 'package:adminpanel/views/widgets/navbar.dart';

class ShopCoinsPage extends StatelessWidget {
  const ShopCoinsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final offers = List.generate(4, (i) => {
      'coins': 'Количество монет',
      'price': 'Цена: ${i + 1}',
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: const NavBar(active: 'Магазин', showBack: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 8),
                const Text('Предложения', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 32),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 2,
                children: [
                  ...offers.map((offer) => _CoinsOfferCard(
                    coins: offer['coins']!,
                    price: offer['price']!,
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

class _CoinsOfferCard extends StatelessWidget {
  final String coins;
  final String price;
  const _CoinsOfferCard({required this.coins, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7E5CF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFE2A86F),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 16),
            Text(coins, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE2A86F),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                child: const Text('Изменить'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
