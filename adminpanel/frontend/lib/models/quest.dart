class Quest {
  final int quest_ID;
  final String name;
  final String description;
  final int progress;
  final int target;
  final int rewardCoins;
  final List<dynamic> rewardPacks; // TODO: заменить на List<Pack> после создания модели Pack
  final bool isCompleted;
  final bool isClaimed;

  Quest({
    required this.quest_ID,
    required this.name,
    required this.description,
    required this.progress,
    required this.target,
    required this.rewardCoins,
    required this.rewardPacks,
    required this.isCompleted,
    required this.isClaimed,
  });
} 