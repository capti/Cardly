import 'package:flutter/material.dart';
import 'home_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _exchangesDeclineEnabled = true;
  bool _inventoryDisplayEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E3), // Бежевый фон
      body: Stack(
        children: [
          // Основное содержимое
          Container(
            margin: const EdgeInsets.only(top: 40.0),
            decoration: BoxDecoration(
              color: const Color(0xFFEDD6B0),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Заголовок "Настройки"
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, left: 24.0),
                  child: Text(
                    'Настройки',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                // Подсказка
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(right: 16.0, top: 8.0),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'Текст\nподсказки',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16.0),
                
                // Опция "Уведомления"
                _buildSettingItem(
                  title: 'Уведомления',
                  hasSwitch: false,
                  onTap: () {
                    // Действие при нажатии на опцию "Уведомления"
                  },
                ),
                
                // Опция "Отклонение обменов"
                _buildSettingItem(
                  title: 'Отклонение обменов',
                  hasSwitch: true,
                  switchValue: _exchangesDeclineEnabled,
                  hasInfo: true,
                  onChanged: (value) {
                    setState(() {
                      _exchangesDeclineEnabled = value;
                    });
                  },
                ),
                
                // Опция "Показ инвентаря"
                _buildSettingItem(
                  title: 'Показ инвентаря',
                  hasSwitch: true,
                  switchValue: _inventoryDisplayEnabled,
                  hasInfo: true,
                  onChanged: (value) {
                    setState(() {
                      _inventoryDisplayEnabled = value;
                    });
                  },
                ),
                
                const Spacer(),
                
                // Кнопка "Выйти из аккаунта"
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Логика выхода из аккаунта
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6A067),
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Выйти из аккаунта',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Кнопка закрытия (X)
          Positioned(
            top: 50.0,
            right: 16.0,
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: const Color(0xFFD6A067),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(8.0),
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 22.0,
                ),
              ),
            ),
          ),
          
          // Нижняя навигационная панель
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFD6A067),
              ),
              child: BottomNavigationBar(
                currentIndex: 0,
                onTap: (index) {
                  if (index == 0) { // Только для главного меню
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (route) => false,
                    );
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
          ),
        ],
      ),
    );
  }
  
  // Строка настройки
  Widget _buildSettingItem({
    required String title,
    bool hasSwitch = false,
    bool hasInfo = false,
    bool switchValue = false,
    VoidCallback? onTap,
    Function(bool)? onChanged,
  }) {
    return InkWell(
      onTap: hasSwitch ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Row(
          children: [
            // Название настройки
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            
            // Иконка информации
            if (hasInfo)
              Container(
                margin: const EdgeInsets.only(left: 8.0),
                width: 20.0,
                height: 20.0,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'i',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            
            const Spacer(),
            
            // Переключатель
            if (hasSwitch)
              Container(
                width: 26.0,
                height: 26.0,
                decoration: BoxDecoration(
                  color: switchValue ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: switchValue
                    ? const Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 18.0,
                      )
                    : null,
              ),
          ],
        ),
      ),
    );
  }
} 