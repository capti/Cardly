class Theme {
  final int theme_ID;
  final String name;
  final String description;
  final String imageURL;
  final int cost;

  Theme({
    required this.theme_ID,
    required this.name,
    required this.description,
    required this.imageURL,
    required this.cost,
  });

  factory Theme.fromJson(Map<String, dynamic> json) {
    return Theme(
      theme_ID: json['theme_ID'],
      name: json['name'],
      description: json['description'],
      imageURL: json['imageURL'],
      cost: json['cost'],
    );
  }
} 