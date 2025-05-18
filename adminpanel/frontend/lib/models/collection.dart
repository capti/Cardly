import 'package:adminpanel/models/card.dart';

class Collection {
  final int collection_ID;
  final String name;
  final List<CardModel> cards;
  final String imageURL;

  Collection({
    required this.collection_ID,
    required this.name,
    required this.cards,
    required this.imageURL,
  });
} 