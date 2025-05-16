class CardModel {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final int rarity;
  final String collection;
  final String type;
  final int disassemblePrice;
  final int quantity;

  CardModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rarity,
    required this.collection,
    required this.type,
    required this.disassemblePrice,
    required this.quantity,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      rarity: json['rarity'] as int,
      collection: json['collection'] as String,
      type: json['type'] as String,
      disassemblePrice: json['disassemblePrice'] as int,
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'rarity': rarity,
      'collection': collection,
      'type': type,
      'disassemblePrice': disassemblePrice,
      'quantity': quantity,
    };
  }
} 