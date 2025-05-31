import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';
import 'news_screen.dart';
import '../services/api_service.dart';
import '../models/quest_model.dart';
import '../utils/error_formatter.dart';

class QuestsDialogContent extends StatefulWidget {
  const QuestsDialogContent({super.key});

  @override
  State<QuestsDialogContent> createState() => _QuestsDialogContentState();
}

class _QuestsDialogContentState extends State<QuestsDialogContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: _selectedTab);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 380,
          constraints: const BoxConstraints(maxHeight: 450),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF4E3),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0, right: 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Верхняя панель с прогрессом и наградой
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, right: 128.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD6A067),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          'Выполнено квестов 0/5',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // TabBar как в магазине
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAD7C3),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          dividerColor: Colors.transparent,
                          indicator: const BoxDecoration(
                            color: Color(0xFFD6A067),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: const [
                            Tab(text: 'Ежедневные квесты'),
                            Tab(text: 'Недельные квесты'),
                          ],
                          onTap: (index) {
                            setState(() {
                              _selectedTab = index;
                            });
                          },
                        ),
                      ),
                    ),
                    // Содержимое вкладок
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildDailyQuestsTab(),
                          _buildWeeklyQuestsTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Кнопка закрытия
              Positioned(
                top: -2.0,
                right: -2.0,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD6A067),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: const Icon(Icons.close, color: Colors.black, size: 32),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyQuestsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildQuestItem('Ежедневный квест', 200);
      },
    );
  }

  Widget _buildWeeklyQuestsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildQuestItem('Недельный квест', 1000);
      },
    );
  }

  Widget _buildQuestItem(String title, int reward) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
            decoration: BoxDecoration(
              color: const Color(0xFFD6A067),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12.0),
                Text(
                  reward.toString(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4.0),
                Image.asset(
                  'assets/icons/монеты.png',
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Функция для показа модального окна квестов
void showQuestsDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
      child: const SizedBox(
        width: 380,
        child: QuestsDialogContent(),
      ),
    ),
  );
}

class QuestsScreen extends StatefulWidget {
  const QuestsScreen({super.key});

  @override
  State<QuestsScreen> createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  late bool _isLoading;
  late Map<String, List<Quest>> _quests;
  late String _error;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _quests = {
      'dailyQuests': [],
      'weeklyQuests': []
    };
    _error = '';
    _loadQuests();
  }

  Future<void> _loadQuests() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final quests = await ApiService().getQuests();
      
      setState(() {
        _quests = quests;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = ErrorFormatter.formatError(e);
      });
    }
  }

  Future<void> _toggleQuestStatus(Quest quest) async {
    try {
      final updatedQuest = await ApiService().changeQuestStatus(quest.quest_ID);
      await _loadQuests(); // Перезагружаем все квесты для обновления UI
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ErrorFormatter.formatError(e))),
      );
    }
  }

  Future<void> _claimReward(String questType) async {
    try {
      final result = await ApiService().claimQuestReward(questType);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Получено: ${result['receivedCoins']} монет')),
      );
      await _loadQuests(); // Перезагружаем квесты после получения награды
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ErrorFormatter.formatError(e))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Квесты'),
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(child: Text(_error))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildQuestSection('Ежедневные квесты', _quests['dailyQuests']!, 'daily'),
                      _buildQuestSection('Еженедельные квесты', _quests['weeklyQuests']!, 'weekly'),
                    ],
                  ),
                ),
    );
  }

  Widget _buildQuestSection(String title, List<Quest> quests, String questType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: quests.length,
          itemBuilder: (context, index) {
            final quest = quests[index];
            return ListTile(
              title: Text(quest.title),
              subtitle: Text(quest.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${quest.progress}/${quest.maxProgress}'),
                  Checkbox(
                    value: quest.isCompleted,
                    onChanged: (bool? value) => _toggleQuestStatus(quest),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _claimReward(questType),
            child: const Text('Получить награду'),
          ),
        ),
      ],
    );
  }
} 