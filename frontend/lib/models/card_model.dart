class CardModel {
  final int card_ID;
  final String name;
  final String description;
  final String imageURL;
  final String rarity;
  final bool isInCollection;
  final DateTime dateObtained;

  CardModel({
    required this.card_ID,
    required this.name,
    required this.description,
    required this.imageURL,
    required this.rarity,
    this.isInCollection = false,
    required this.dateObtained,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      card_ID: json['card_ID'],
      name: json['name'],
      description: json['description'],
      imageURL: json['imageURL'],
      rarity: json['rarity'],
      isInCollection: json['isInCollection'] ?? false,
      dateObtained: DateTime.parse(json['dateObtained']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'card_ID': card_ID,
      'name': name,
      'description': description,
      'imageURL': imageURL,
      'rarity': rarity,
      'isInCollection': isInCollection,
      'dateObtained': dateObtained.toIso8601String(),
    };
  }
} 