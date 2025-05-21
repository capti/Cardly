import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';
import 'news_detail_screen.dart';
import 'profile_screen.dart';
import 'search_players_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _currentIndex = 0; // Changed from 1 to 0 to select Home tab
  
  // Примерные данные новостей (без использования типа DateTime для избежания ошибок)
  final List<NewsItem> _newsItems = [
    NewsItem(
      title: 'Заголовок к новости',
      content: 'Текст новости',
      date: '12.05.2023',
      fullContent: 'Расширенное описание новости с дополнительными подробностями о событии или объявлении.',
    ),
    NewsItem(
      title: 'Заголовок к новости',
      content: 'Текст новости',
      date: '10.05.2023',
      fullContent: 'Расширенное описание новости с дополнительными подробностями о событии или объявлении.',
    ),
    NewsItem(
      title: 'Заголовок к новости',
      content: 'Текст новости',
      date: '08.05.2023',
      fullContent: 'Расширенное описание новости с дополнительными подробностями о событии или объявлении.',
    ),
    NewsItem(
      title: 'Заголовок к новости',
      content: 'Текст новости',
      date: '05.05.2023',
      fullContent: 'Расширенное описание новости с дополнительными подробностями о событии или объявлении.',
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF), // Бежевый фон
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF6EF),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            width: 40.0,
            height: 40.0,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              child: Image.asset('assets/icons/профиль.png', height: 22),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/поиск.png',
              height: 32,
              color: Colors.black,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const SearchPlayersModal(),
              );
            },
          ),
          IconButton(
            icon: Image.asset(
              'assets/icons/уведомления.png',
              height: 36,
              color: Colors.black,
            ),
            onPressed: null,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Кнопка возврата и заголовок
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Кнопка назад
                Container(
                  margin: const EdgeInsets.only(left: 0.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD6A067),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                        (route) => false,
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 16.0),
                
                // Заголовок "Новости"
                const Center(
                  child: Text(
                    'Новости',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16.0),
          
          // Список новостей
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _newsItems.length,
              itemBuilder: (context, index) {
                return _buildNewsItem(_newsItems[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFD6A067),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
              switch (index) {
                case 0:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                  break;
                case 1:
                  // Current screen is NewsScreen, do nothing or handle appropriately
                  break;
                case 2:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ShopScreen()),
                  );
                  break;
                case 3:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ExchangesScreen()),
                  );
                  break;
              }
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedIconTheme: const IconThemeData(
            size: 28,
          ),
          unselectedIconTheme: const IconThemeData(
            size: 24,
          ),
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 11,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/главная.png', height: 24),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDD6B0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('assets/icons/главная.png', height: 24),
              ),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/Инвентарь.png', height: 24),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDD6B0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('assets/icons/Инвентарь.png', height: 24),
              ),
              label: 'Инвентарь',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/магазин.png', height: 24),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDD6B0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('assets/icons/магазин.png', height: 24),
              ),
              label: 'Магазин',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/обменник.png', height: 24),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDD6B0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('assets/icons/обменник.png', height: 24),
              ),
              label: 'Обменник',
            ),
          ],
        ),
      ),
    );
  }
  
  // Метод для отображения элемента новости
  Widget _buildNewsItem(NewsItem news) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => NewsDetailScreen(news: news),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFEAD7C3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок
            Text(
              news.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            
            const SizedBox(height: 8.0),
            
            // Текст
            Text(
              news.content,
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Класс для хранения данных новости
class NewsItem {
  final String title;
  final String content;
  final String date;
  final String fullContent;
  
  NewsItem({
    required this.title,
    required this.content,
    required this.date,
    required this.fullContent,
  });
} 