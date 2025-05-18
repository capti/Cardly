import '../models/news.dart';
import 'package:flutter/material.dart';

class NewsController extends ChangeNotifier {
  final List<News> _newsList = [
    News(
      news_ID: 1,
      title: 'Заголовок новости 1',
      content: 'Текст новости 1',
      pictures: [],
      datePosted: DateTime.now(),
    ),
    News(
      news_ID: 2,
      title: 'Заголовок новости 2',
      content: 'Текст новости 2',
      pictures: [],
      datePosted: DateTime.now(),
    ),
  ];

  List<News> get newsList => List.unmodifiable(_newsList);

  void publishNews({required String title, required String content, required List<String> pictures}) {
    final news = News(
      news_ID: DateTime.now().millisecondsSinceEpoch,
      title: title,
      content: content,
      pictures: pictures,
      datePosted: DateTime.now(),
    );
    _newsList.insert(0, news);
    notifyListeners();
  }

  void deleteNews(int news_ID) {
    _newsList.removeWhere((n) => n.news_ID == news_ID);
    notifyListeners();
  }
} 