import 'package:flutter/material.dart';
import 'exchanges_screen.dart';

class ExchangeDetailsScreen extends StatelessWidget {
  const ExchangeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFFFF4E3),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(color: Colors.black, width: 2),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 346, maxWidth: 346, minHeight: 0),
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
                          'CardMaster475',
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
                        // Stack из двух карточек (стопка)
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 6,
                              top: -4,
                              child: _buildCardItem('Карточка 2', 'Обычная', width: 48, height: 64),
                            ),
                            _buildCardItem('Карточка 1', 'Обычная', width: 48, height: 64),
                          ],
                        ),
                        // Статус по центру
                        Expanded(
                          child: Center(
                            child: Text(
                              'В ожидании',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Jost',
                              ),
                            ),
                          ),
                        ),
                        // Карточка пользователя
                        _buildCardItem('Карточка пользователя', 'Редкая', width: 48, height: 64),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 729,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD6A067),
                              foregroundColor: Colors.black,
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Jost',
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              _showConfirmationDialog(context, 'Принять обмен?', false);
                            },
                            child: const Text('Принять'),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        SizedBox(
                          width: 729,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD6A067),
                              foregroundColor: Colors.black,
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Jost',
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              _showConfirmationDialog(context, 'Отклонить обмен?', true);
                            },
                            child: const Text('Отклонить'),
                          ),
                        ),
                      ],
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

  Widget _buildCardItem(String title, String rarity, {double width = 80, double height = 120}) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFD9A76A),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: const Color(0xFFD9A76A),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black, width: 1.5),
        ),
        child: Stack(
          children: [
            // Горизонтальная линия внизу
            Positioned(
              left: 0,
              right: 0,
              bottom: height * 0.2,
              child: Container(
                height: 2,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String message, bool isDecline) {
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
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                // Передаю текст уведомления на ExchangesScreen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExchangesScreen(
                      notification: isDecline ? 'Обмен отклонен' : 'Обмен принят',
                    ),
                  ),
                  (route) => false,
                );
              },
              child: Text(isDecline ? 'Отклонить' : 'Принять'),
            ),
          ],
        );
      },
    );
  }
} 