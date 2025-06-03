import 'package:flutter/material.dart';
import '../models/achievement_model.dart';
import '../services/api_service.dart';
import '../utils/error_formatter.dart';
import '../utils/auth_utils.dart';

class AchievementsScreen extends StatefulWidget {
  final bool isOtherUser;
  final int userId;

  const AchievementsScreen({
    Key? key, 
    required this.isOtherUser, 
    required this.userId
  }) : super(key: key);

  @override
  _AchievementsScreenState createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  late bool _isLoading;
  late List<Achievement> _achievements;
  late String _error;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _achievements = [];
    _error = '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (AuthUtils.checkGuestAccess(context, 'achievements_screen')) {
        _loadAchievements();
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  Future<void> _loadAchievements() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final achievements = widget.isOtherUser 
          ? await ApiService().getOtherProfileAchievements(widget.userId)
          : await ApiService().getAchievements();
      
      setState(() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Достижения${widget.isOtherUser ? ' игрока' : ''}'),
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(child: Text(_error))
              : ListView.builder(
                  itemCount: _achievements.length,
                  itemBuilder: (context, index) {
                    final achievement = _achievements[index];
                    return ListTile(
                      leading: Image.network(achievement.imageURL),
                      title: Text(achievement.name),
                      subtitle: Text(achievement.description),
                      trailing: achievement.isCompleted
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : const Icon(Icons.lock, color: Colors.grey),
                    );
                  },
                ),
    );
  }
}
