import 'package:adminpanel/models/card.dart';
import 'package:adminpanel/models/achievement.dart';

class Notification {
  // TODO: Определить структуру Notification
}

class ProfileData {
  // TODO: Определить структуру ProfileData
}

class User {
  final int userId;
  final String username;
  final String email;
  final String password;
  final List<CardModel> favorites;
  final List<CardModel> inventoryCards;
  final List<CardModel> onChange;
  final int balance;
  final String avatarUrl;
  final List<Achievement> achievements;
  final List<Achievement> favoritesAchievements;
  final List<Notification> notifications;
  final ProfileData profileData;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.favorites,
    required this.inventoryCards,
    required this.onChange,
    required this.balance,
    required this.avatarUrl,
    required this.achievements,
    required this.favoritesAchievements,
    required this.notifications,
    required this.profileData,
  });
} 