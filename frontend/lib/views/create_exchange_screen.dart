import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';
import 'inventory_screen.dart';
import 'profile_screen.dart';

class CreateExchangeScreen extends StatefulWidget {
  final ExchangeItem? initialExchangeItem;

  const CreateExchangeScreen({super.key, this.initialExchangeItem});

  @override
  State<CreateExchangeScreen> createState() => _CreateExchangeScreenState();
}

class _CreateExchangeScreenState extends State<CreateExchangeScreen> {
  int _currentIndex = 3;
  Map<String, dynamic>? selectedTopCard;
  List<Map<String, dynamic>> selectedExchangeCards = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialExchangeItem != null && widget.initialExchangeItem!.otherUserOfferedCardIds.isNotEmpty) {
      selectedTopCard = {
        'id': widget.initialExchangeItem!.otherUserOfferedCardIds[0],
        'name': 'Карта ${widget.initialExchangeItem!.otherUserOfferedCardIds[0]}',
      };
    }
  }

  void _showCardSelectionDialog({
    required String title,
    required Function(Map<String, dynamic>) onCardSelected,
    required bool Function(int) isCardSelected,
    required bool Function() canSelectMore,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFFFFF4E3),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: const EdgeInsets.only(top: 24.0, bottom: 16.0, left: 16.0, right: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Jost',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: 40,
                          itemBuilder: (context, index) {
                            bool isSelected = isCardSelected(index);
                            return GestureDetector(
                              onTap: () {
                                if (!isSelected && canSelectMore()) {
                                  onCardSelected({
                                    'id': index,
                                    'name': 'Карта $index',
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              child: _buildExchangeCardVisual(
                                width: 100,
                                height: 140,
                                content: Center(child: Text('Карта $index', style: const TextStyle(color: Colors.black, fontSize: 10, fontFamily: 'Jost'),)),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Close button in the top right corner
                Positioned(
                  top: 0,
                  right: -2,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Color(0xFFD6A067),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        );
      },
    );
  }

  void _showTopCardSelectionDialog() {
    _showCardSelectionDialog(
      title: 'Выберите вашу карту',
      onCardSelected: (card) {
        setState(() {
          selectedTopCard = card;
        });
      },
      isCardSelected: (index) => selectedTopCard?['id'] == index,
      canSelectMore: () => true,
    );
  }

  void _showLargeCardSelectionDialog() {
    _showCardSelectionDialog(
      title: 'Выберите карту для обмена',
      onCardSelected: (card) {
        setState(() {
          selectedExchangeCards.add(card);
        });
      },
      isCardSelected: (index) => selectedExchangeCards.any((card) => card['id'] == index),
      canSelectMore: () => selectedExchangeCards.length < 8,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4E3),
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFD6A067),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Заголовок "Ваша карта для обмена"
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              widget.initialExchangeItem != null ? 'Вы получите' : 'Ваша карта для обмена',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontFamily: 'Jost',
              ),
            ),
          ),
          // Карточка для выбора своей карты (одноразовый выбор)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: selectedTopCard == null
              ? GestureDetector(
                  onTap: _showTopCardSelectionDialog,
                  child: _buildExchangeCardVisual(
                    width: 78,
                    height: 112,
                    content: Center(
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                )
              : _buildExchangeCardVisual(
                  width: 78,
                  height: 112,
                  content: Center(child: Text('Карта ${selectedTopCard!['id']}', style: const TextStyle(color: Colors.black, fontSize: 10, fontFamily: 'Jost'),)),
                ),
          ),
          const SizedBox(height: 20.0),
          // Текст для карт обмена
          Column(
            children: [
              Text(
                widget.initialExchangeItem != null ? 'Вы готовы' : 'Карта, на которую вы',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontFamily: 'Jost',
                ),
              ),
              Text(
                widget.initialExchangeItem != null ? 'предложить взамен' : 'готовы произвести обмен',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontFamily: 'Jost',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          // Ряды карточек для обмена (многоразовый выбор)
          Expanded(
            child: _buildExchangeCardsRow(),
          ),
          // Кнопка создания обмена
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: widget.initialExchangeItem != null
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Container(
                            width: 367,
                            height: 61,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAD7C3),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                            child: const Center(
                              child: Text(
                                'Обмен успешно отправлен',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Jost',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          backgroundColor: Colors.transparent,
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height - 200,
                            left: 16,
                            right: 16,
                          ),
                          elevation: 0,
                        ),
                      );
                      
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const ExchangesScreen(initialTabIndex: 1)),
                        (route) => false,
                      );
                    }
                  : (selectedTopCard == null || selectedExchangeCards.isEmpty)
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(
                                width: 367,
                                height: 61,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEDD6B0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                child: const Center(
                                  child: Text(
                                    'Добавьте карточки для обмена',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Jost',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height - 120,
                                left: 16,
                                right: 16,
                              ),
                              elevation: 0,
                            ),
                          );
                        }
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(
                                width: 367,
                                height: 61,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEAD7C3),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                child: const Center(
                                  child: Text(
                                    'Обмен создан',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Jost',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height - 200,
                                left: 16,
                                right: 16,
                              ),
                              elevation: 0,
                            ),
                          );

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const ExchangesScreen()),
                            (route) => false,
                          );
                        },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD6A067),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                disabledBackgroundColor: const Color(0xFFD6A067).withOpacity(0.7),
                disabledForegroundColor: Colors.black.withOpacity(0.5),
              ),
              child: Text(
                widget.initialExchangeItem != null ? 'Предложить обмен' : 'Создать обмен',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Jost',
                ),
              ),
            ),
          ),
          // Нижняя навигация
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFD6A067),
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                if (widget.initialExchangeItem == null) {
                  if (index != _currentIndex) {
                    switch (index) {
                      case 0:
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                          (route) => false,
                        );
                        break;
                      case 1:
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const InventoryScreen()),
                          (route) => false,
                        );
                        break;
                      case 2:
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const ShopScreen()),
                          (route) => false,
                        );
                        break;
                      case 3:
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const ExchangesScreen()),
                          (route) => false,
                        );
                        break;
                    }
                  }
                }
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black54,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedIconTheme: const IconThemeData(
                size: 24,
              ),
              unselectedIconTheme: const IconThemeData(
                size: 24,
              ),
              selectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'Jost',
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontFamily: 'Jost',
              ),
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/главная.png', height: 24),
                  activeIcon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDD6B0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset('assets/icons/главная.png', height: 24),
                  ),
                  label: 'Главная',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/Инвентарь.png', height: 24),
                  activeIcon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDD6B0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset('assets/icons/Инвентарь.png', height: 24),
                  ),
                  label: 'Инвентарь',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/магазин.png', height: 24),
                  activeIcon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDD6B0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset('assets/icons/магазин.png', height: 24),
                  ),
                  label: 'Магазин',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/обменник.png', height: 24),
                  activeIcon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDD6B0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset('assets/icons/обменник.png', height: 24),
                  ),
                  label: 'Обменник',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeCardVisual({Widget? content, double width = 80, double height = 120, VoidCallback? onRemove}) {
    // Calculate internal heights based on the provided height
    double totalNonContentHeight = 3 + 3 + 3 + 2 + 1; // Borders, padding, and line from inventory card
    double availableContentHeight = height - totalNonContentHeight;
    double imageHeight = availableContentHeight * 0.65; // Approximate proportion for image area
    double rarityHeight = availableContentHeight * 0.2; // Approximate proportion for rarity area

    // Ensure calculated heights are non-negative
    imageHeight = imageHeight > 0 ? imageHeight : 0;
    rarityHeight = rarityHeight > 0 ? rarityHeight : 0;

    return Container(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Внешняя тонкая черная рамка
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 2),
            ),
          ),
          // Прослойка цвета карточки
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD6A067), // Use the same color as inventory card
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          // Внутренняя тонкая черная рамка
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black, width: 2),
              ),
            ),
          ),
          // Основная карточка
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD6A067), // Use the same color as inventory card
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),
                      child: Container(
                        color: const Color(0xFFEAD7C3), // Background color for image area
                        height: imageHeight,
                        child: content ?? const Center( // Use provided content or default placeholder
                          child: Text(
                            'Нет изображения',
                            style: TextStyle(color: Colors.black45, fontSize: 10), // Adjusted font size
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 3,
                    color: Colors.black, // Separator color
                  ),
                  Container(
                    height: rarityHeight,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD6A067), // Rarity section color
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(4, (i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Image.asset(
                          'assets/icons/редкость.png', // Rarity icon
                          height: rarityHeight > 0 ? rarityHeight * 0.5 : 0, // Adjust icon size proportionally
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Positioned close button - now a direct child of the outer Stack
          if (onRemove != null) // Only show if onRemove callback is provided
            Positioned(
              top: 0, // Adjust position as needed
              right: -3, // Adjust position as needed
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  width: 16, // Adjusted size
                  height: 16, // Adjusted size
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4E3),
                    borderRadius: BorderRadius.circular(3), // Adjusted radius
                    border: Border.all(color: Colors.black, width: 1), // Match style
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.close,
                      size: 12, // Adjusted icon size
                      color: Colors.black, // Match color
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildExchangeCardsRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Первый ряд карточек (максимум 4)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                ...selectedExchangeCards.take(4).map((card) => Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: _buildExchangeCardVisual(
                    width: 78,
                    height: 112,
                    content: Center(child: Text('Карта ${card['id']}', style: const TextStyle(color: Colors.black, fontSize: 10, fontFamily: 'Jost'),)),
                    onRemove: () {
                      setState(() {
                        selectedExchangeCards.remove(card);
                      });
                    },
                  ),
                )).toList(),
                if (selectedExchangeCards.length < 4)
                  GestureDetector(
                    onTap: _showLargeCardSelectionDialog,
                    child: _buildExchangeCardVisual(
                      width: 78,
                      height: 112,
                      content: Center(
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        // Второй ряд карточек (максимум 4)
        if (selectedExchangeCards.length >= 4)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...selectedExchangeCards.skip(4).take(4).map((card) => Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: _buildExchangeCardVisual(
                      width: 78,
                      height: 112,
                      content: Center(child: Text('Карта ${card['id']}', style: const TextStyle(color: Colors.black, fontSize: 10, fontFamily: 'Jost'),)),
                      onRemove: () {
                        setState(() {
                          selectedExchangeCards.remove(card);
                        });
                      },
                    ),
                  )).toList(),
                  if (selectedExchangeCards.length < 8)
                    GestureDetector(
                      onTap: _showLargeCardSelectionDialog,
                      child: _buildExchangeCardVisual(
                        width: 78,
                        height: 112,
                        content: Center(
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
} 