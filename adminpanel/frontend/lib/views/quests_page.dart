import 'package:flutter/material.dart';
import 'package:adminpanel/views/news_page.dart';
import 'package:adminpanel/views/collections_page.dart';
import 'package:adminpanel/views/widgets/navbar.dart';

class QuestsPage extends StatelessWidget {
  const QuestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: const NavBar(active: 'Главная', showBack: false),
      body: Center(
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              Padding(
                padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7E5CF),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_back, size: 32, color: Colors.black),
                    ),
                  ),
                ),
              ),
              // Main content
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    Container(
                      width: 900,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDE9D6),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                      child: Column(
                        children: [
                          // Daily Quests
                          const Text(
                            'Ежедневные квесты',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          _QuestTable(
                            quests: List.generate(6, (i) => _QuestData('Ежедневный квест', 200)),
                          ),
                          const Divider(thickness: 2),
                          // Weekly Quests
                          const Text(
                            'Еженедельные квесты',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          _QuestTable(
                            quests: List.generate(4, (i) => _QuestData('Недельный квест', 1000)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

class _QuestData {
  final String name;
  final int reward;
  _QuestData(this.name, this.reward);
}

class _QuestTable extends StatelessWidget {
  final List<_QuestData> quests;
  const _QuestTable({required this.quests});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: quests.map((q) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(q.name, style: const TextStyle(fontSize: 16)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF3C690),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Text(q.reward.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 4),
                  const Icon(Icons.monetization_on, color: Color(0xFFE2A86F), size: 20),
                ],
              ),
            ),
            const SizedBox(width: 16),
            _QuestActionButton('Удалить', onPressed: () {}),
            const SizedBox(width: 8),
            _QuestActionButton('Изменить', onPressed: () {}),
          ],
        ),
      )).toList(),
    );
  }
}

class _QuestActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const _QuestActionButton(this.label, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE2A86F),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
} 