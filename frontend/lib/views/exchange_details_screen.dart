import 'package:flutter/material.dart';
import 'exchanges_screen.dart';

class ExchangeDetailsScreen extends StatelessWidget {
  final ExchangeItem exchangeItem;

  const ExchangeDetailsScreen({super.key, required this.exchangeItem});

  @override
  Widget build(BuildContext context) {
    // Helper to get status text
    String getStatusText(ExchangeStatus status) {
      switch (status) {
        case ExchangeStatus.pending: return 'Ожидает\nподтверждения';
        case ExchangeStatus.waiting: return 'Ожидает\nдействий';
        case ExchangeStatus.approved: return 'Завершен';
        case ExchangeStatus.rejected: return 'Отклонен';
      }
    }

    return Dialog(
      backgroundColor: const Color(0xFFEAD7C3),
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(color: Colors.black, width: 2),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1.6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Дата и никнейм в одной строке
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 2.0, right: 54.0, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '12.05.2023',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Jost',
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          exchangeItem.nickname,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Jost',
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Карточки и статус как на скрине
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Cards offered by the current user (stacked if more than one)
                        exchangeItem.myOfferedCardIds.length > 1
                            ? Stack(
                                clipBehavior: Clip.none, // Allow cards to overlap
                          children: [
                                  // Show up to 3 cards in the stack (visual representation)
                                  Positioned(
                                    left: 12, // Adjust position for stacking
                                    top: 0, // Adjust position for stacking
                                    child: _buildCardItem('Card Name', 'Rarity', width: 48, height: 64), // TODO: Use actual card details from cardId
                                  ),
                            Positioned(
                                    left: 6, // Adjust position for stacking
                                    top: 0, // Adjust position for stacking
                                    child: _buildCardItem('Card Name', 'Rarity', width: 48, height: 64), // TODO: Use actual card details from cardId
                            ),
                                  // Always show the front card if count is at least 1
                                  _buildCardItem('Card Name', 'Rarity', width: 48, height: 64), // TODO: Use actual card details from cardId
                          ],
                              )
                            : (exchangeItem.myOfferedCardIds.isNotEmpty
                                ? _buildCardItem('Card Name', 'Rarity', width: 48, height: 64) // Single card
                                : SizedBox.shrink()), // No cards

                        // Статус по центру
                        Expanded(
                          child: Center(
                            child: Text(
                              getStatusText(exchangeItem.status), // Use the exchange status
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Jost',
                              ),
                            ),
                          ),
                        ),
                        // Cards offered by the other user (stacked if more than one)
                        exchangeItem.otherUserOfferedCardIds.length > 1
                            ? Stack(
                                clipBehavior: Clip.none, // Allow cards to overlap
                                children: [
                                  // Show up to 3 cards in the stack (visual representation)
                                  Positioned(
                                    left: 12, // Adjust position for stacking
                                    top: 0, // Adjust position for stacking
                                    child: _buildCardItem('Card Name', 'Rarity', width: 48, height: 64), // TODO: Use actual card details from cardId
                                  ),
                                  Positioned(
                                    left: 6, // Adjust position for stacking
                                    top: 0, // Adjust position for stacking
                                    child: _buildCardItem('Card Name', 'Rarity', width: 48, height: 64), // TODO: Use actual card details from cardId
                                  ),
                                  // Always show the front card if count is at least 1
                                  _buildCardItem('Card Name', 'Rarity', width: 48, height: 64), // TODO: Use actual card details from cardId
                                ],
                              )
                            : (exchangeItem.otherUserOfferedCardIds.isNotEmpty
                                ? _buildCardItem('Card Name', 'Rarity', width: 48, height: 64) // Single card
                                : SizedBox.shrink()), // No cards
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  // Conditionally display buttons based on status
                  if (exchangeItem.status == ExchangeStatus.waiting) // Show both buttons if waiting for actions
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD6A067),
                              foregroundColor: Colors.black,
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto',
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExchangesScreen(
                                      notification: 'Обмен принят',
                                    ),
                                  ),
                                  (route) => false,
                                );
                            },
                            child: const Text('Принять'),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD6A067),
                              foregroundColor: Colors.black,
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto',
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExchangesScreen(
                                      notification: 'Обмен отклонен',
                                    ),
                                  ),
                                  (route) => false,
                                );
                            },
                            child: const Text('Отклонить'),
                          ),
                        ),
                      ],
                    ),
                    )
                  else if (exchangeItem.status == ExchangeStatus.pending) // Show only Cancel button if pending
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD6A067),
                            foregroundColor: Colors.black,
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExchangesScreen(
                                  notification: 'Обмен отклонен',
                                ),
                              ),
                              (route) => false,
                            );
                          },
                          child: const Text('Отменить'), // Text for cancelling pending exchange
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ),
          // Крестик в стиле магазина с внутренним отступом
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(0xFFD6A067),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 3),
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardItem(String title, String rarity, {double width = 48, double height = 64}) {
    // Precise calculation of vertical space consumed by non-content elements:
    // Outer border (top + bottom): 1.5 + 1.5 = 3
    // Padding (top + bottom) within outer border: 1.5 + 1.5 = 3
    // Inner border (top + bottom) after first padding: 1.5 + 1.5 = 3
    // Padding (top + bottom) after inner border: 1.0 + 1.0 = 2
    // Separator line: 1
    double totalNonContentHeight = 3 + 3 + 3 + 2 + 1; // Total vertical space used by borders, padding, and line

    double availableContentHeight = height - totalNonContentHeight; // Height remaining for image and rarity areas

    // Distribute available height based on desired proportions (approx. 65/35 split)
    double imageHeight = availableContentHeight * 0.65;
    double rarityHeight = availableContentHeight * 0.2;

    // Ensure calculated heights are non-negative
    imageHeight = imageHeight > 0 ? imageHeight : 0;
    rarityHeight = rarityHeight > 0 ? rarityHeight : 0;

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
                        height: imageHeight, // Use precisely calculated height
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
                        height: rarityHeight, // Use precisely calculated height
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
                            height: rarityHeight > 0 ? rarityHeight * 0.7 : 0, // Adjust icon size proportionally
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