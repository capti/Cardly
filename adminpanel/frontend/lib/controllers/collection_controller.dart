import 'package:flutter/material.dart';
import '../models/collection.dart';
import '../models/card.dart';

class CollectionController extends ChangeNotifier {
  final List<Collection> _collections = [];

  List<Collection> get collections => List.unmodifiable(_collections);

  CardModel? addCardToCollection(int card_ID) {
    for (var collection in _collections) {
      try {
        final card = collection.cards.firstWhere((c) => c.card_ID == card_ID);
        // Карта уже есть в коллекции
        return card;
      } catch (_) {}
    }
    // В реальном приложении нужно знать, в какую коллекцию добавить карту
    // Здесь просто возвращаем null
    return null;
  }

  CardModel? removeCardFromCollection(int card_ID) {
    for (var collection in _collections) {
      final index = collection.cards.indexWhere((c) => c.card_ID == card_ID);
      if (index != -1) {
        final card = collection.cards.removeAt(index);
        notifyListeners();
        return card;
      }
    }
    return null;
  }

  void changeCollectionAvatar(int collection_ID, String imageURL) {
    final index = _collections.indexWhere((c) => c.collection_ID == collection_ID);
    if (index != -1) {
      final collection = _collections[index];
      _collections[index] = Collection(
        collection_ID: collection.collection_ID,
        name: collection.name,
        cards: collection.cards,
        imageURL: imageURL,
      );
      notifyListeners();
    }
  }

  void createCollection(Collection collection) {
    _collections.add(collection);
    notifyListeners();
  }

  void deleteCollection(int collection_ID) {
    _collections.removeWhere((c) => c.collection_ID == collection_ID);
    notifyListeners();
  }
} 