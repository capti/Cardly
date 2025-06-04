import 'card_model.dart';

class Trade {
  final int trade_ID;
  final int initiatorID;
  final String initiatorUsername;
  final CardModel offeredCard;
  final List<CardModel> requestedCards;
  final String status; // 'pending', 'accepted', 'rejected', 'cancelled'
  final DateTime createdAt;

  Trade({
    required this.trade_ID,
    required this.initiatorID,
    required this.initiatorUsername,
    required this.offeredCard,
    required this.requestedCards,
    required this.status,
    required this.createdAt,
  });

  factory Trade.fromJson(Map<String, dynamic> json) {
    return Trade(
      trade_ID: json['trade_ID'],
      initiatorID: json['initiatorID'],
      initiatorUsername: json['initiatorUsername'],
      offeredCard: CardModel.fromJson(json['offeredCard']),
      requestedCards: (json['requestedCards'] as List)
          .map((card) => CardModel.fromJson(card))
          .toList(),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
} 