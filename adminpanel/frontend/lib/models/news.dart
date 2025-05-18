class News {
  final int news_ID;
  final String title;
  final String content;
  final List<String> pictures;
  final DateTime datePosted;

  News({
    required this.news_ID,
    required this.title,
    required this.content,
    required this.pictures,
    required this.datePosted,
  });
} 