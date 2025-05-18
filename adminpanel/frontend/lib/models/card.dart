class ThemeModel {
  final String name;
  ThemeModel({required this.name});
}

class CardModel {
  final int card_ID;
  final String name;
  final String description;
  final String imageURL;
  final String rarity;
  final int min_price;
  final ThemeModel theme;
  final bool isGenerated;

  CardModel({
    required this.card_ID,
    required this.name,
    required this.description,
    required this.imageURL,
    required this.rarity,
    required this.min_price,
    required this.theme,
    required this.isGenerated,
  });
} 