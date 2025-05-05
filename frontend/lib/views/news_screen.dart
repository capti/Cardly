import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _currentIndex = 1; // Индекс для нижней навигации (книга)
  
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
      backgroundColor: const Color(0xFFFFF4E3), // Бежевый фон
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4E3),
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Image.asset(
            'assets/icons/профиль.png',
            height: 24,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/поиск.png',
              height: 24,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(
              'assets/icons/уведомления.png',
              height: 24,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Кнопка возврата и заголовок
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Кнопка назад
                Container(
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                  break;
                case 2:
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const ShopScreen()),
                    (route) => false,
                  );
                  break;
                case 3:
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const ExchangesScreen()),
                    (route) => false,
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
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/главная.png', height: 24),
              label: 'Гл.меню',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/Инвентарь.png', height: 24),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/магазин.png', height: 24),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/обменник.png', height: 24),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
  
  // Метод для отображения элемента новости
  Widget _buildNewsItem(NewsItem news) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEDD6B0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Левая часть - заголовок
          Expanded(
            flex: 1,
            child: Text(
              news.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
          
          const SizedBox(width: 16.0),
          
          // Правая часть - текст
          Expanded(
            flex: 1,
            child: Text(
              news.content,
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
        ],
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