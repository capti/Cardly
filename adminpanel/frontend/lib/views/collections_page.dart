import 'package:flutter/material.dart';
import 'package:adminpanel/views/achievements_page.dart';
import 'package:adminpanel/views/quests_page.dart';
import 'package:adminpanel/views/news_page.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color(0xFFE2A86F),
          elevation: 0,
          title: Row(
            children: [
              const SizedBox(width: 8),
              _NavBarItem('Главная', selected: true, onTap: () {}),
              _NavBarItem('Новости', onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const NewsPage()),
                );
              }),
              _NavBarItem('Пользователи'),
              _NavBarItem('Обмены'),
              _NavBarItem('Жалобы'),
              _NavBarItem('Магазин'),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Выйти',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Коллекции',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _TopButton('Квесты', selected: true, onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const QuestsPage()),
                  );
                }),
                const SizedBox(width: 16),
                _TopButton('Достижения', onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AchievementsPage()),
                  );
                }),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 32,
                crossAxisSpacing: 32,
                children: List.generate(7, (index) {
                  if (index == 6) {
                    return _AddCollectionCard();
                  }
                  return _CollectionCard();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  const _NavBarItem(this.label, {this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}

class _TopButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onPressed;
  const _TopButton(this.label, {this.selected = false, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? const Color(0xFFE2A86F) : const Color(0xFFF3C690),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7E5CF),
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}

class _AddCollectionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7E5CF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Center(
        child: Icon(
          Icons.add,
          size: 48,
          color: Colors.black,
        ),
      ),
    );
  }
} 