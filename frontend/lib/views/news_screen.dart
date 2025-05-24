import 'package:flutter/material.dart';
import 'news_detail_screen.dart';
import 'profile_screen.dart';
import 'search_players_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFD6A067),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 29.0,
                      ),
                    ),
                  ),
                ),
              ],
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
                  fontFamily: 'Jost',
                ),
              ),
            ),
            
            const SizedBox(height: 16.0),
            
            // Список новостей
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _newsItems.length,
                itemBuilder: (context, index) {
                  return _buildNewsItem(context, _newsItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Метод для отображения элемента новости
  Widget _buildNewsItem(BuildContext context, NewsItem news) {
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
                fontFamily: 'Jost',
              ),
            ),
            
            const SizedBox(height: 8.0),
            
            // Текст
            Text(
              news.content,
              style: const TextStyle(
                fontSize: 14.0,
                fontFamily: 'Jost',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Примерные данные новостей
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