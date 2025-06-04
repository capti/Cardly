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

class Pack {
  final int pack_ID;
  final String name;
  final String description;
  final String imageURL;
  final int price;
  final int cardsCount;
  final bool isAvailable;

  Pack({
    required this.pack_ID,
    required this.name,
    required this.description,
    required this.imageURL,
    required this.price,
    required this.cardsCount,
    this.isAvailable = true,
  });

  factory Pack.fromJson(Map<String, dynamic> json) {
    return Pack(
      pack_ID: json['pack_ID'],
      name: json['name'],
      description: json['description'],
      imageURL: json['imageURL'],
      price: json['price'],
      cardsCount: json['cardsCount'],
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pack_ID': pack_ID,
      'name': name,
      'description': description,
      'imageURL': imageURL,
      'price': price,
      'cardsCount': cardsCount,
      'isAvailable': isAvailable,
    };
  }
}

class CoinOffer {
  final int offer_ID;
  final int coins;
  final double price;
  final bool isPopular;
  final bool isBestValue;

  CoinOffer({
    required this.offer_ID,
    required this.coins,
    required this.price,
    this.isPopular = false,
    this.isBestValue = false,
  });

  factory CoinOffer.fromJson(Map<String, dynamic> json) {
    return CoinOffer(
      offer_ID: json['offer_ID'],
      coins: json['coins'],
      price: json['price'].toDouble(),
      isPopular: json['isPopular'] ?? false,
      isBestValue: json['isBestValue'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'offer_ID': offer_ID,
      'coins': coins,
      'price': price,
      'isPopular': isPopular,
      'isBestValue': isBestValue,
    };
  }
} 