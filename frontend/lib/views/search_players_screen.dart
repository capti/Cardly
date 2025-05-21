import 'package:flutter/material.dart';
import 'profile_screen.dart';

class SearchPlayersModal extends StatelessWidget {
  const SearchPlayersModal({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PlayerItem> players = [
      PlayerItem(name: 'Cardly', cards: 5, id: '123456'),
      PlayerItem(name: 'Cardly1', cards: 5, id: '123457'),
      PlayerItem(name: 'Cardly2', cards: 5, id: '123458'),
      PlayerItem(name: 'Cardly3', cards: 5, id: '123459'),
      PlayerItem(name: 'Cardly4', cards: 5, id: '123460'),
    ];
    final TextEditingController _searchController = TextEditingController();
    final double modalHeight = MediaQuery.of(context).size.height * 0.6;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 330),
        child: Container(
          height: modalHeight,
          width: MediaQuery.of(context).size.width * 0.98,
          decoration: const BoxDecoration(
            color: Color(0xFFEAD7C3),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: Container(
                        height: 36,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF4E3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Введите ник пользователя',
                            hintStyle: TextStyle(
                              fontFamily: 'Jost',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () => _searchController.clear(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Colors.black26),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    return PlayerListItem(player: players[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Модель данных игрока
class PlayerItem {
  final String name;
  final int cards;
  final String id;

  PlayerItem({
    required this.name,
    required this.cards,
    required this.id,
  });
}

// Виджет элемента списка игроков
class PlayerListItem extends StatelessWidget {
  final PlayerItem player;

  const PlayerListItem({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context); // Закрываем модальное окно поиска
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(
              isOtherUser: true,
              playerName: player.name,
              playerId: player.id,
              cardsCollected: player.cards,
              collectionsCollected: 2, // Примерное значение, в реальном приложении должно приходить с сервера
            ),
          ),
        );
      },
      child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Аватар пользователя как в profile_screen
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFEAD7C3),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: const Center(
              child: Icon(Icons.person_outline, size: 28, color: Colors.black),
            ),
          ),
          const SizedBox(width: 12.0),
          // Имя пользователя
          Text(
            player.name,
            style: const TextStyle(
              fontFamily: 'Jost',
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          // Карточки пользователя (макет из инвентаря, но без фото)
          Row(
            children: List.generate(
              player.cards,
              (index) => Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: CardMockup(),
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}

// Макет карточки как в инвентаре, но без фото
class CardMockup extends StatelessWidget {
  const CardMockup({super.key});

  @override
  Widget build(BuildContext context) {
    double width = 32;
    double height = 44;
    
    // Precise calculation of vertical space consumed by non-content elements
    double totalNonContentHeight = 3 + 3 + 3 + 2 + 1; // Total vertical space used by borders, padding, and line
    double availableContentHeight = height - totalNonContentHeight;
    double imageHeight = availableContentHeight * 0.65;
    double rarityHeight = availableContentHeight * 0.2;

    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFD6A067),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: Padding(
                padding: EdgeInsets.zero,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6A067),
                    borderRadius: BorderRadius.circular(1.0),
                  ),
                  child: Column(
                    children: [
                      // Image placeholder area
                      Container(
                        height: imageHeight,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEAD7C3),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(1.0),
                            topRight: Radius.circular(1.0),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Нет \n изоб',
                            style: TextStyle(color: Colors.black45, fontSize: 7),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      // Rarity icons area
                      Container(
                        height: rarityHeight,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD6A067),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(1.0),
                            bottomRight: Radius.circular(1.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(4, (i) => Image.asset(
                            'assets/icons/редкость.png',
                            height: rarityHeight > 0 ? rarityHeight * 0.7 : 0,
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
} 