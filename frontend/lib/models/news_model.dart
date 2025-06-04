class News {
  final int news_ID;
  final String title;
  final String content;
  final String imageURL;
  final DateTime publishDate;

  News({
    required this.news_ID,
    required this.title,
    required this.content,
    required this.imageURL,
    required this.publishDate,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      news_ID: json['news_ID'],
      title: json['title'],
      content: json['content'],
      imageURL: json['imageURL'],
      publishDate: DateTime.parse(json['publishDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'news_ID': news_ID,
      'title': title,
      'content': content,
      'imageURL': imageURL,
      'publishDate': publishDate.toIso8601String(),
    };
  }
} 