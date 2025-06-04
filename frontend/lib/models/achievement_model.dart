class Achievement {
  final int achievement_ID;
  final String name;
  final String description;
  final String imageURL;
  final int progress;
  final int maxProgress;
  final bool isCompleted;
  final bool isFavorite;

  Achievement({
    required this.achievement_ID,
    required this.name,
    required this.description,
    required this.imageURL,
    required this.progress,
    required this.maxProgress,
    required this.isCompleted,
    required this.isFavorite,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      achievement_ID: json['achievement_ID'],
      name: json['name'],
      description: json['description'],
      imageURL: json['imageURL'],
      progress: json['progress'],
      maxProgress: json['maxProgress'],
      isCompleted: json['isCompleted'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'achievement_ID': achievement_ID,
      'name': name,
      'description': description,
      'imageURL': imageURL,
      'progress': progress,
      'maxProgress': maxProgress,
      'isCompleted': isCompleted,
      'isFavorite': isFavorite,
    };
  }
}