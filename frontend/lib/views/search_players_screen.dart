import 'package:flutter/material.dart';

class SearchPlayersScreen extends StatefulWidget {
  const SearchPlayersScreen({super.key});

  @override
  State<SearchPlayersScreen> createState() => _SearchPlayersScreenState();
}

class _SearchPlayersScreenState extends State<SearchPlayersScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<PlayerItem> _players = [
    PlayerItem(name: 'Cardly', cards: 5),
    PlayerItem(name: 'Cardly1', cards: 5),
    PlayerItem(name: 'Cardly2', cards: 5),
    PlayerItem(name: 'Cardly3', cards: 5),
    PlayerItem(name: 'Cardly4', cards: 5),
  ];
  
  int _currentIndex = 0;
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E3), // Бежевый фон
      appBar: AppBar(
        backgroundColor: const Color(0xFFEDD6B0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Cardly',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
            size: 24.0,
          ),
        ),
      ),
      body: Column(
        children: [
          // Основное содержимое - список игроков
          Expanded(
            child: Container(
              color: const Color(0xFFEDD6B0),
              child: ListView.builder(
                itemCount: _players.length,
                itemBuilder: (context, index) {
                  return PlayerListItem(player: _players[index]);
                },
              ),
            ),
          ),
          
          // Кнопка "Создай свою уникальную карточку"
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD6A067),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Создай свою уникальную карточку',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          
          // Кнопки "Квесты" и "Новости"
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Row(
              children: [
                // Кнопка "Квесты"
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6A067),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/icons/квесты.png',
                          height: 24,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 4.0),
                        const Text(
                          'Квесты',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(width: 12.0),
                
                // Кнопка "Новости"
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6A067),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/icons/новости.png',
                          height: 24,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 4.0),
                        const Text(
                          'Новости',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Нижняя навигационная панель
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFD6A067),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black54,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/главная.png', height: 24),
                  label: 'Гл.меню',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/Инвентарь.png', height: 24),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/магазин.png', height: 24),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/обменник.png', height: 24),
                  label: '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Модель данных игрока
class PlayerItem {
  final String name;
  final int cards;
  
  PlayerItem({required this.name, required this.cards});
}

// Виджет элемента списка игроков
class PlayerListItem extends StatelessWidget {
  final PlayerItem player;
  
  const PlayerListItem({super.key, required this.player});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          // Аватар пользователя
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Image.asset(
              'assets/icons/профиль.png',
              height: 24,
              color: Colors.black,
            ),
          ),
          
          const SizedBox(width: 16.0),
          
          // Имя пользователя
          Text(
            player.name,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const Spacer(),
          
          // Коллекция карточек пользователя
          Row(
            children: List.generate(
              player.cards,
              (index) => Container(
                margin: const EdgeInsets.only(left: 4.0),
                width: 32,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6A067),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 