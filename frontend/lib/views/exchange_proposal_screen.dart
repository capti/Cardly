import 'package:flutter/material.dart';
import 'package:cardly/views/create_exchange_screen.dart'; // Import to reuse _buildExchangeCardVisual
import 'package:cardly/views/exchanges_screen.dart'; // Import ExchangeItem

class ExchangeProposalScreen extends StatelessWidget {
  final ExchangeItem exchangeItem;

  const ExchangeProposalScreen({super.key, required this.exchangeItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E3), // Match background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFD6A067),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context), // Back button
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title: Вы получите:
            const Text(
              'Вы получите:',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Jost',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10.0),
            // Other user's offered card
            // TODO: Display actual card based on passed data
            _buildExchangeCardVisual( // Reuse card visual
              width: 80, // Approximate size from image
              height: 120, // Approximate size from image
              content: Center(child: Text('Карта \n${exchangeItem.otherUserOfferedCardIds.isNotEmpty ? exchangeItem.otherUserOfferedCardIds[0] : 'N/A'}', textAlign: TextAlign.center, style: const TextStyle(color: Colors.black, fontSize: 10, fontFamily: 'Jost'),)),
            ),
            const SizedBox(height: 20.0),
            // Title: Пользователь хочет получить:
            const Text(
              'Пользователь хочет получить:',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Jost',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10.0),
            // Your available cards section
            SizedBox( // Fixed height container for the card section
              height: 300.0, // Set a fixed height to control button position
              child: Center( // Keep the Center widget to center the Wrap block horizontally within the SizedBox
                child: Wrap(
                  alignment: WrapAlignment.center, // Center items in the wrap layout
                  spacing: 10.0, // Horizontal space between cards
                  runSpacing: 10.0, // Vertical space between rows of cards
                  children: exchangeItem.myOfferedCardIds.map((cardId) {
                    // TODO: Display your actual cards from inventory
                    return _buildExchangeCardVisual(
                      width: 80, // Match size with the one above
                      height: 120, // Match size
                      content: Center(child: Text('Ваша\nКарта $cardId', textAlign: TextAlign.center, style: const TextStyle(color: Colors.black, fontSize: 10, fontFamily: 'Jost'),)),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 130.0), // Increased space before buttons
            // Buttons
            ElevatedButton(
              onPressed: () {
                // TODO: Implement logic for 'Обменяться картой из списка'
                 Navigator.pop(context); // Close ExchangeProposalScreen
                 Navigator.pushAndRemoveUntil(
                   context,
                   MaterialPageRoute(
                     builder: (context) => const ExchangesScreen(
                       notification: 'Обмен успешно совершен', // Notification message
                     ),
                   ),
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
              ),
              child: Text(
                exchangeItem.myOfferedCardIds.length == 1 ? 'Обменяться картой из списка' : 'Обменяться картами из списка',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Jost',
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateExchangeScreen(
                      initialExchangeItem: exchangeItem,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD6A067),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                exchangeItem.myOfferedCardIds.length == 1 ? 'Предложить другую карту' : 'Предложить другие карты',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Jost',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reuse the _buildExchangeCardVisual from create_exchange_screen.dart
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