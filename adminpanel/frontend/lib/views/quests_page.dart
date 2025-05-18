import 'package:flutter/material.dart';
import 'package:adminpanel/views/news_page.dart';
import 'package:adminpanel/views/collections_page.dart';
import 'package:adminpanel/views/widgets/navbar.dart';
import 'package:adminpanel/models/quest.dart';
import 'package:adminpanel/views/create_quest_page.dart';
import 'package:adminpanel/views/edit_quest_page.dart';
import 'package:provider/provider.dart';
import 'package:adminpanel/controllers/quest_controller.dart';

class QuestsPage extends StatefulWidget {
  const QuestsPage({Key? key}) : super(key: key);

  @override
  State<QuestsPage> createState() => _QuestsPageState();
}

class _QuestsPageState extends State<QuestsPage> {
  @override
  Widget build(BuildContext context) {
    final questController = Provider.of<QuestController>(context);
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Квесты',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE2A86F),
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  elevation: 0,
                                ),
                                onPressed: () async {
                                  final quest = await Navigator.of(context).push<Quest>(
                                    MaterialPageRoute(builder: (context) => const CreateQuestPage()),
                                  );
                                  if (quest != null) {
                                    questController.addQuest(quest);
                                  }
                                },
                                child: const Text('Добавить квест', style: TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _QuestTable(
                            quests: questController.quests,
                            onEdit: (index) async {
                              final quest = questController.quests[index];
                              final edited = await Navigator.of(context).push<Quest>(
                                MaterialPageRoute(builder: (context) => EditQuestPage(quest: quest)),
                              );
                              if (edited != null) {
                                questController.editQuest(edited);
                              }
                            },
                            onDelete: (index) {
                              final quest = questController.quests[index];
                              questController.deleteQuest(quest.quest_ID);
                            },
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

class _QuestTable extends StatelessWidget {
  final List<Quest> quests;
  final void Function(int) onEdit;
  final void Function(int) onDelete;
  const _QuestTable({required this.quests, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: quests.asMap().entries.map((entry) {
        final i = entry.key;
        final q = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(q.name, style: const TextStyle(fontSize: 16)),
              ),
              Expanded(
                flex: 3,
                child: Text(q.description, style: const TextStyle(fontSize: 14, color: Colors.black54)),
              ),
              Expanded(
                child: Text('${q.progress}/${q.target}', style: const TextStyle(fontSize: 14)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3C690),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(q.rewardCoins.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 4),
                    const Icon(Icons.monetization_on, color: Color(0xFFE2A86F), size: 20),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              _QuestActionButton('Удалить', onPressed: () => onDelete(i)),
              const SizedBox(width: 8),
              _QuestActionButton('Изменить', onPressed: () => onEdit(i)),
            ],
          ),
        );
      }).toList(),
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