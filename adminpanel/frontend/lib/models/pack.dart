import 'package:adminpanel/models/card.dart';

class Pack {
  final int packId;
  final String name;
  final String imageUrl;
  final List<CardModel> cards;
  final int price;

  Pack({
    required this.packId,
    required this.name,
    required this.imageUrl,
    required this.cards,
    required this.price,
  });
}

// TODO: Определить класс Card или импортировать его, если он уже существует. 