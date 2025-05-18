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
    return ChangeNotifierProvider(
      create: (_) => NewsController(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF8F7),
        appBar: const NavBar(active: 'Новости', showBack: false),
        body: _NewsPageBody(),
      ),
    );
  }
}

class _NewsPageBody extends StatelessWidget {
  const _NewsPageBody();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<NewsController>(context);
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
              itemCount: controller.newsList.length,
              itemBuilder: (context, index) {
                final news = controller.newsList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(
                          title: news.title,
                          description: news.text,
                          imageBytes: null, // пока нет интеграции с картинками
                        ),
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
                              const SizedBox(height: 16),
                              Text(
                                news.text,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Roboto',
                                ),
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
                              onPressed: () => controller.removeNews(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE2A86F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                elevation: 0,
                              ),
                              child: const Text('Удалить', style: TextStyle(color: Colors.black)),
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
                controller.addNews(News(title: titleController.text, text: textController.text));
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