import 'package:flutter/material.dart';
import '../models/quest.dart';

class QuestController extends ChangeNotifier {
  final List<Quest> _quests = [];

  List<Quest> get quests => List.unmodifiable(_quests);

  void addQuest(Quest quest) {
    _quests.add(quest);
    notifyListeners();
  }

  void editQuest(Quest quest) {
    final index = _quests.indexWhere((q) => q.quest_ID == quest.quest_ID);
    if (index != -1) {
      _quests[index] = quest;
      notifyListeners();
    }
  }

  void deleteQuest(int quest_ID) {
    _quests.removeWhere((q) => q.quest_ID == quest_ID);
    notifyListeners();
  }
} 