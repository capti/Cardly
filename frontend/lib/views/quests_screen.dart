import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';
import 'news_screen.dart';

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