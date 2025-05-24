import 'package:flutter/material.dart';
import 'inventory_screen.dart';
import 'search_players_screen.dart';
import 'create_card_screen.dart';
import 'news_screen.dart';
import 'quests_screen.dart';
import 'profile_screen.dart';
import 'notifications_modal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF6EF),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            width: 40.0,
            height: 40.0,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              child: Image.asset('assets/icons/профиль.png', height: 22),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/поиск.png',
              height: 32,
              color: Colors.black,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const SearchPlayersModal(),
              );
            },
          ),
          IconButton(
            icon: Image.asset(
              'assets/icons/уведомления.png',
              height: 36,
              color: Colors.black,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const NotificationsModal(),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
            child: Text(
              'Коллекции',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Jost',
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.75,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                // Dummy collection names for demonstration
                final List<String> collectionNames = [
                  'Весна',
                  'Лето',
                  'Осень',
                  'Зима',
                  'Горы',
                  'Море',
                  'Лес',
                  'Город'
                ];
                
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InventoryScreen(
                          collectionName: collectionNames[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAD7C3),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Text(
                        collectionNames[index],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Jost',
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 120.0),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateCardScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD6A067),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Создай свою уникальную карточку',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 32.0),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showQuestsDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6A067),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/icons/квесты.png',
                          height: 42,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 0.0),
                        const Text(
                          'Квесты',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(width: 20.0),
                
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewsScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6A067),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/icons/новости.png',
                          height: 42,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 0.0),
                        const Text(
                          'Новости',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: null,
    );
  }
}