import 'package:flutter/material.dart';
import '../models/achievement.dart';

class AchievementController extends ChangeNotifier {
  final List<Achievement> _achievements = [];

  List<Achievement> get achievements => List.unmodifiable(_achievements);

  void addAchievement(Achievement achievement) {
    _achievements.add(achievement);
    notifyListeners();
  }

  void editAchievement(Achievement achievement) {
    final index = _achievements.indexWhere((a) => a.achievement_ID == achievement.achievement_ID);
    if (index != -1) {
      _achievements[index] = achievement;
      notifyListeners();
    }
  }

  void deleteAchievement(int achievement_ID) {
    _achievements.removeWhere((a) => a.achievement_ID == achievement_ID);
    notifyListeners();
  }
} 