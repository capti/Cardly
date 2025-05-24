import 'package:flutter/material.dart';
import 'home_screen.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  bool _notificationsEnabled = true;
  bool _exchangesDeclineEnabled = true;
  bool _inventoryDisplayEnabled = true;

  String? _hintText;
  bool _showHint = false;

  void _showHintMessage(String text) {
    setState(() {
      _hintText = text;
      _showHint = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (_showHint) {
          setState(() {
            _showHint = false;
          });
        }
      },
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.88,
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
              color: const Color(0xFFEAD7C3),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Center(
                        child: Text(
                          'Настройки',
                          style: TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 28.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      _buildSettingItem(
                        title: 'Уведомления',
                        hasSwitch: true,
                        switchValue: _notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            _notificationsEnabled = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16.0),
                      _buildSettingItem(
                        title: 'Отклонение обменов',
                        hasSwitch: true,
                        switchValue: _exchangesDeclineEnabled,
                        hasInfo: true,
                        onInfoTap: () => _showHintMessage('Подсказка по отклонению обменов'),
                        onChanged: (value) {
                          setState(() {
                            _exchangesDeclineEnabled = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16.0),
                      _buildSettingItem(
                        title: 'Показ инвентаря',
                        hasSwitch: true,
                        switchValue: _inventoryDisplayEnabled,
                        hasInfo: true,
                        onInfoTap: () => _showHintMessage('Подсказка по показу инвентаря'),
                        onChanged: (value) {
                          setState(() {
                            _inventoryDisplayEnabled = value;
                          });
                        },
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 26.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:(){},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD6A067),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 18.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              'Выйти из аккаунта',
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -1,
                  right: -1,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6A067),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.black,
                          size: 44.0,
                        ),
                      ),
                    ),
                  ),
                ),
                if (_showHint && _hintText != null)
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.35,
                    top: _hintText!.contains('обменов') ? 195 : 255,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 160,
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          _hintText!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    bool hasSwitch = false,
    bool hasInfo = false,
    bool switchValue = false,
    Function(bool)? onChanged,
    VoidCallback? onInfoTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Jost',
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (hasInfo)
            GestureDetector(
              onTap: onInfoTap,
              child: Container(
                margin: const EdgeInsets.only(left: 8.0),
                width: 22.0,
                height: 22.0,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '!',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Jost',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          const Spacer(),
          if (hasSwitch)
            GestureDetector(
              onTap: () => onChanged?.call(!switchValue),
              child: Container(
                width: 56.0,
                height: 32.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6A067),
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Align(
                  alignment: switchValue ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: switchValue
                        ? const Icon(Icons.check, color: Colors.black, size: 16)
                        : null,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
} 