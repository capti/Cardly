class Achievement {
  final int achievement_ID;
  final String name;
  final String imageURL;
  final String description;
  final bool isUnlocked;

  Achievement({
    required this.achievement_ID,
    required this.name,
    required this.imageURL,
    required this.description,
    required this.isUnlocked,
  });
} 