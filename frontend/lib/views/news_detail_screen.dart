import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../utils/error_formatter.dart';
import '../services/analytics_service.dart';

// Remove unused imports
// import 'home_screen.dart';
// import 'shop_screen.dart';
// import 'exchanges_screen.dart';
// import 'profile_screen.dart';
// import 'search_players_screen.dart';

class NewsDetailScreen extends StatelessWidget {
  final News news;

  const NewsDetailScreen({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnalyticsService.trackScreenView('news_detail_screen');
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.imageURL != null)
              Image.network(
                news.imageURL,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            Text(
              news.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Опубликовано: ${_formatDate(news.publishDate)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Text(
              news.content,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }
} 