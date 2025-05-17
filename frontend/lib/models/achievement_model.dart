class Achievement {
  final String id;
  final String title;
  final String description;
  final String requirement;
  final String iconPath;
  final bool isCompleted;
  final double progress;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.requirement,
    required this.iconPath,
    this.isCompleted = false,
    this.progress = 0.0,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      requirement: json['requirement'] as String,
      iconPath: json['iconPath'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'requirement': requirement,
      'iconPath': iconPath,
      'isCompleted': isCompleted,
      'progress': progress,
    };
  }
}