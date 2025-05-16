import 'card_model.dart';

class PackModel {
  final int id;
  final String name;
  final String imageUrl;
  final int price;
  final List<CardModel> cards;

  PackModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.cards,
  });

  factory PackModel.fromJson(Map<String, dynamic> json) {
    return PackModel(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      price: json['price'] as int,
      cards: (json['cards'] as List)
          .map((card) => CardModel.fromJson(card))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'cards': cards.map((card) => card.toJson()).toList(),
    };
  }
}

class CoinOfferModel {
  final int id;
  final String name;
  final String? description;
  final int coinsAmount;
  final double price;
  final String imageUrl;

  CoinOfferModel({
    required this.id,
    required this.name,
    this.description,
    required this.coinsAmount,
    required this.price,
    required this.imageUrl,
  });

  factory CoinOfferModel.fromJson(Map<String, dynamic> json) {
    return CoinOfferModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      coinsAmount: json['coinsAmount'] as int,
      price: json['price'] as double,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'coinsAmount': coinsAmount,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}

class PurchasePackResponse {
  final List<CardModel> receivedCards;
  final int newBalance;

  PurchasePackResponse({
    required this.receivedCards,
    required this.newBalance,
  });

  factory PurchasePackResponse.fromJson(Map<String, dynamic> json) {
    return PurchasePackResponse(
      receivedCards: (json['receivedCards'] as List)
          .map((card) => CardModel.fromJson(card))
          .toList(),
      newBalance: json['newBalance'] as int,
    );
  }
}

class PurchaseCoinsResponse {
  final String paymentUrl;

  PurchaseCoinsResponse({
    required this.paymentUrl,
  });

  factory PurchaseCoinsResponse.fromJson(Map<String, dynamic> json) {
    return PurchaseCoinsResponse(
      paymentUrl: json['paymentUrl'] as String,
    );
  }
} 