import 'package:flutter/material.dart';
import '../models/news.dart';

class NewsController extends ChangeNotifier {
  final List<News> _newsList = [
    News(title: 'Заголовок новости', text: 'Текст новости'),
    News(title: 'Заголовок новости', text: 'Текст новости'),
    News(title: 'Заголовок новости', text: 'Текст новости'),
    News(title: 'Заголовок новости', text: 'Текст новости'),
  ];

  List<News> get newsList => List.unmodifiable(_newsList);

  void addNews(News news) {
    _newsList.insert(0, news);
    notifyListeners();
  }

  void removeNews(int index) {
    _newsList.removeAt(index);
    notifyListeners();
  }
} 