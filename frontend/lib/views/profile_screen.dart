import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'exchanges_screen.dart';
import 'inventory_screen.dart';
import 'settings_screen.dart' show SettingsDialog;
import 'achievements_screen.dart';
import 'profile_image_dialog.dart';
import '../services/api_service.dart';
import '../utils/error_formatter.dart';
import '../utils/auth_utils.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../services/analytics_service.dart';

class ProfileScreen extends StatefulWidget {
  final bool isOtherUser;
  final String? playerName;
  final String? playerId;
  final int? cardsCollected;
  final int? collectionsCollected;
  final List<int> favoriteCardIds;

  const ProfileScreen({
    super.key,
    this.isOtherUser = false,
    this.playerName,
    this.playerId,
    this.cardsCollected,
    this.collectionsCollected,
    this.favoriteCardIds = const [],
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool _isLoading;
  late String _error;
  late Map<String, dynamic> _userStats;
  late List<dynamic> _favoriteCards;
  late List<dynamic> _favoriteAchievements;
  late List<dynamic> _achievements;
  late Map<String, dynamic> _settings;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _error = '';
    _settings = {};
    AnalyticsService.trackScreenView('profile_screen');
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final profileData = await ApiService().getProfile();
      final achievements = await ApiService().getAchievements();
      
      setState(() {
        _userStats = profileData['userStats'];
        _favoriteCards = profileData['favoriteCards'];
        _favoriteAchievements = profileData['favoriteAchievements'];
        _achievements = achievements;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = ErrorFormatter.formatError(e);
      });
    }
  }

  Future<void> _toggleAchievementFavorite(int achievementId, bool isFavorite) async {
    try {
      bool success;
      if (isFavorite) {
        success = await ApiService().removeAchievementFromFavorites(achievementId);
      } else {
        success = await ApiService().addAchievementToFavorites(achievementId);
      }

      if (success) {
        await _loadProfileData();
      }
    } catch (e) {
      // Показать ошибку пользователю
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ErrorFormatter.formatError(e))),
      );
    }
  }

  Future<void> _updateSettings() async {
    try {
      await ApiService().updateProfileSettings(_settings);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Настройки успешно сохранены')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ErrorFormatter.formatError(e))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<AuthController>(context).currentUser?.isGuest ?? false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!AuthUtils.checkGuestAccess(context, 'profile_screen')) {
          Navigator.of(context).pop();
        }
      });
      return Container(); // Return empty container while checking
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF6EF),
        elevation: 0,
        title: null,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD6A067),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 29.0,
              ),
            ),
          ),
        ),
        actions: [
          if (widget.isOtherUser)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                width: 40.0,
                height: 40.0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.2),
                      builder: (context) => ReportDialog(playerName: widget.playerName ?? ''),
                    );
                  },
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14159),
                    child: Image.asset(
                      'assets/icons/жалоба.png',
                      height: 22.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                width: 40.0,
                height: 40.0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.2),
                      builder: (context) => const SettingsDialog(),
                    );
                  },
                  child: Image.asset(
                    'assets/icons/настройки.png',
                    color: Colors.black,
                    height: 22.0,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          
          // Аватар пользователя
          GestureDetector(
            onTap: widget.isOtherUser ? null : () {
              showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.2),
                builder: (context) => const ProfileImageUploadDialog(),
              );
            },
            child: Container(
              width: 140.0,
              height: 140.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: const CircleAvatar(
                backgroundColor: Color(0xFFFBF6EF),
                child: Icon(
                  Icons.person_outline,
                  size: 90.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 16.0),
          
          // Имя пользователя
          Text(
            widget.isOtherUser ? widget.playerName ?? '' : 'Ник',
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Jost',
            ),
          ),
          
          const SizedBox(height: 4.0),
          
          // ID пользователя
          Text(
            widget.isOtherUser ? widget.playerId ?? '' : '######',
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black54,
              fontFamily: 'Jost',
            ),
          ),
          
          const SizedBox(height: 16.0),
          
          // Коллекция карточек (5 карточек в ряд)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                5, // Always generate 5 cards
                (index) => _buildCard(
                  index < widget.favoriteCardIds.length ? widget.favoriteCardIds[index] : -1,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 15.0),
          
          // Блок достижений
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                color: const Color(0xFFD6A067),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(4, (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Image.asset(
                          'assets/icons/достижение.png',
                          height: 70,
                          width: 70,
                          fit: BoxFit.contain,
                        ),
                      )),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    bottom: 8,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AchievementsScreen(
                              isOtherUser: widget.isOtherUser,
                              userId: widget.isOtherUser ? int.parse(widget.playerId ?? '0') : 0,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        widget.isOtherUser ? 'Достижения →' : 'Все достижения →',
                        style: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Jost',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 90.0),
          
          // Статистика
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                // Собрано карт
                Row(
                  children: [
                    const Text(
                      'Собрано карт: ',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Jost',
                      ),
                    ),
                    Text(
                      widget.isOtherUser ? (_userStats['cardsCollected']?.toString() ?? '0') : '****',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jost',
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8.0),
                
                // Собрано коллекций
                Row(
                  children: [
                    const Text(
                      'Собрано коллекций: ',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Jost',
                      ),
                    ),
                    Text(
                      widget.isOtherUser ? (_userStats['collectionsCollected']?.toString() ?? '0') : '***',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jost',
                      ),
                    ),
                  ],
                ),
                if (widget.isOtherUser) ...[
                  const SizedBox(height: 18.0),
                  // Кнопка посмотреть инвентарь
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InventoryScreen(
                              isOtherUser: true,
                              playerName: widget.playerName ?? '',
                              playerId: widget.playerId != null ? int.tryParse(widget.playerId!) : null,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Посмотреть инвентарь →',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: 'Jost',
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          const Spacer(),
        ],
      ),
      bottomNavigationBar: null,
    );
  }
  
  // Карточка в профиле
  Widget _buildCard(int cardId) {
    return SizedBox(
      width: 74,
      height: 112,
      child: AspectRatio(
        aspectRatio: 3/4,
        child: Stack(
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
                  color: const Color(0xFFD6A067),
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
                  color: const Color(0xFFD6A067),
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
                          color: const Color(0xFFEAD7C3),
                          child: const Center(
                            child: Text(
                              'Нет изображения',
                              style: TextStyle(color: Colors.black45, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 3,
                      color: Colors.black,
                    ),
                    Container(
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD6A067),
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
                            'assets/icons/редкость.png',
                            height: 10,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportDialog extends StatefulWidget {
  final String playerName;
  const ReportDialog({super.key, required this.playerName});

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  int _selectedReason = 0;
  final TextEditingController _controller = TextEditingController();
  final List<String> _reasons = [
    'причина 1',
    'причина 2',
    'причина 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFEAD7C3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          Container(
            width: 360,
            height: 600,
            padding: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Подать жалобу на пользователя\n${widget.playerName}',
                          style: const TextStyle(fontSize: 17),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  ...List.generate(_reasons.length, (i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      children: [
                        Text(
                          _reasons[i],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(width: 12),
                        Radio<int>(
                          value: i,
                          groupValue: _selectedReason,
                          onChanged: (val) => setState(() => _selectedReason = val!),
                          activeColor: Colors.black,
                        ),
                      ],
                    ),
                  )),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _controller,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Комментарий',
                      filled: true,
                      fillColor: const Color(0xFFFBF6EF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD6A067),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        showTopReportSuccess(context);
                      },
                      child: const Text('Отправить жалобу'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6A067),
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
}

void showTopReportSuccess(BuildContext context) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 40,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEAD7C3),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 8,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 5),
          child: const Center(
            child: Text(
              'Жалоба успешно отправлена',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    ),
  );
  overlay.insert(overlayEntry);
  Future.delayed(const Duration(seconds: 3), () => overlayEntry.remove());
} 