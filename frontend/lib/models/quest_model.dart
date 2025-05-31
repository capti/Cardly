class Quest {
  final int quest_ID;
  final String title;
  final String description;
  final String type; // 'daily' или 'weekly'
  final int progress;
  final int maxProgress;
  final int reward;
  final bool isCompleted;

  Quest({
    required this.quest_ID,
    required this.title,
    required this.description,
    required this.type,
    required this.progress,
    required this.maxProgress,
    required this.reward,
    required this.isCompleted,
  });

  factory Quest.fromJson(Map<String, dynamic> json) {
    return Quest(
      quest_ID: json['quest_ID'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      progress: json['progress'],
      maxProgress: json['maxProgress'],
      reward: json['reward'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quest_ID': quest_ID,
      'title': title,
      'description': description,
      'type': type,
      'progress': progress,
      'maxProgress': maxProgress,
      'reward': reward,
      'isCompleted': isCompleted,
    };
  }
} 