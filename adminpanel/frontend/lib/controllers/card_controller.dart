import 'package:flutter/material.dart';
import '../models/card.dart';

class CardController extends ChangeNotifier {
  final List<CardModel> _cards = [];

  List<CardModel> get cards => List.unmodifiable(_cards);

  void addCard(CardModel card) {
    _cards.add(card);
    notifyListeners();
  }

  void editCard(CardModel card) {
    final index = _cards.indexWhere((c) => c.card_ID == card.card_ID);
    if (index != -1) {
      _cards[index] = card;
      notifyListeners();
    }
  }

  void deleteCard(int card_ID) {
    _cards.removeWhere((c) => c.card_ID == card_ID);
    notifyListeners();
  }
} 