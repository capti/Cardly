import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';

class ExchangeDetailsScreen extends StatefulWidget {
  const ExchangeDetailsScreen({super.key});

  @override
  State<ExchangeDetailsScreen> createState() => _ExchangeDetailsScreenState();
}

class _ExchangeDetailsScreenState extends State<ExchangeDetailsScreen> {
  int _currentIndex = 3; // Индекс вкладки "Обмены" в нижней навигации
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E3), // Бежевый фон
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4E3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Детали обмена',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Информация об обмене
            Card(
              color: const Color(0xFFD6A067),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Обмен #12345',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Text(
                            'В ожидании',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                      'Дата создания: 12.05.2023',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: const [
                        Icon(Icons.person, size: 16.0),
                        SizedBox(width: 4.0),
                        Text(
                          'Пользователь: CardMaster2000',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: const [
                        Icon(Icons.swap_horiz, size: 16.0),
                        SizedBox(width: 4.0),
                        Text(
                          'Тип: 2 карточки на 1 карточку',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20.0),
            
            // Секция "Мои карточки"
            const Text(
              'Мои карточки для обмена:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return _buildCardItem('Карточка ${index + 1}', 'Редкость: Обычная');
                },
              ),
            ),
            
            const SizedBox(height: 20.0),
            
            // Секция "Карточки пользователя"
            const Text(
              'Карточки пользователя для обмена:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return _buildCardItem('Карточка пользователя', 'Редкость: Редкая');
                },
              ),
            ),
            
            const SizedBox(height: 24.0),
            
            // Кнопки действий
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      // Логика отклонения обмена
                      _showConfirmationDialog('Отклонить обмен?', true);
                    },
                    child: const Text('Отклонить'),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      // Логика принятия обмена
                      _showConfirmationDialog('Принять обмен?', false);
                    },
                    child: const Text('Принять'),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16.0),
            
            // Кнопка отмены (для своих обменов)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD6A067),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                minimumSize: const Size(double.infinity, 48.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                // Логика отмены обмена
                _showConfirmationDialog('Вы уверены, что хотите отменить свой обмен?', true);
              },
              child: const Text(
                'Отменить обмен',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFD6A067),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
              
              // Навигация в зависимости от выбранного индекса
              switch (index) {
                case 0: // Главное меню
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                  break;
                case 2: // Магазин
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const ShopScreen()),
                    (route) => false,
                  );
                  break;
                case 3: // Обмены
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const ExchangesScreen()),
                    (route) => false,
                  );
                  break;
              }
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/главная.png', height: 24),
              label: 'Главная',
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
    );
  }
  
  // Метод для создания виджета карточки
  Widget _buildCardItem(String title, String rarity) {
    return Container(
      width: 120.0,
      margin: const EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFD6A067),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black54, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Изображение карточки (заглушка)
          Container(
            height: 100.0,
            decoration: BoxDecoration(
              color: const Color(0xFFEDD6B0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 40.0, color: Colors.black54),
            ),
          ),
          // Информация о карточке
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  rarity,
                  style: const TextStyle(
                    fontSize: 12.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Метод для отображения диалога подтверждения
  void _showConfirmationDialog(String message, bool isDecline) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFF4E3),
          title: Text(message),
          content: Text(
            isDecline
                ? 'Это действие невозможно будет отменить.'
                : 'Карточки будут переданы между участниками обмена.',
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: isDecline ? Colors.red : Colors.green,
              ),
              onPressed: () {
                // Выполнить действие
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Вернуться на предыдущий экран
                
                // Здесь можно добавить вызов API для обработки обмена
              },
              child: Text(isDecline ? 'Отклонить' : 'Принять'),
            ),
          ],
        );
      },
    );
  }
} 