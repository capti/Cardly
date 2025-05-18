import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/news_controller.dart';
import '../models/news.dart';
import 'package:adminpanel/views/collections_page.dart';
import 'package:adminpanel/views/create_news_page.dart';
import 'package:adminpanel/views/news_detail_page.dart';
import 'package:adminpanel/views/widgets/navbar.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: const NavBar(active: 'Новости', showBack: false),
      body: Consumer<NewsController>(
        builder: (context, newsController, _) => _NewsPageBody(newsController: newsController),
      ),
    );
  }
}

class _NewsPageBody extends StatelessWidget {
  final NewsController newsController;
  const _NewsPageBody({required this.newsController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const CreateNewsPage()),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.black),
                label: const Text('Добавить новость', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEAD6C3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  elevation: 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: newsController.newsList.length,
              itemBuilder: (context, index) {
                final news = newsController.newsList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(news: news),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAD6C3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (news.pictures.isNotEmpty)
                          Container(
                            width: 80,
                            height: 80,
                            margin: const EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[300],
                            ),
                            child: Image.network(news.pictures.first, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.image)),
                          ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                news.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                news.content,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Дата: 	${news.datePosted.toLocal().toString().split(' ')[0]}',
                                style: const TextStyle(fontSize: 11, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CreateNewsPage(
                                      // Для редактирования: передать title, text, imageBytes (если будет)
                                      // Пока только title и text
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE2A86F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                elevation: 0,
                              ),
                              child: const Text('Редактировать', style: TextStyle(color: Colors.black)),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () => newsController.deleteNews(news.news_ID),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE2A86F),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                elevation: 0,
                              ),
                              child: const Text('Удалить', style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddNewsDialog(BuildContext context, NewsController controller) {
    final titleController = TextEditingController();
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить новость'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Заголовок'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: textController,
              decoration: const InputDecoration(hintText: 'Текст'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && textController.text.isNotEmpty) {
                controller.publishNews(
                  title: titleController.text,
                  content: textController.text,
                  pictures: [],
                );
                Navigator.of(context).pop();
              }
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }
} 