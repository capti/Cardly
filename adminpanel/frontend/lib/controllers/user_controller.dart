import 'package:adminpanel/models/user.dart';

class UserController {
  User _user;

  UserController(this._user);

  User get user => _user;

  void editBalance(int amount) {
    _user = User(
      userId: _user.userId,
      username: _user.username,
      email: _user.email,
      password: _user.password,
      favorites: _user.favorites,
      inventoryCards: _user.inventoryCards,
      onChange: _user.onChange,
      balance: amount,
      avatarUrl: _user.avatarUrl,
      achievements: _user.achievements,
      favoritesAchievements: _user.favoritesAchievements,
      notifications: _user.notifications,
      profileData: _user.profileData,
    );
  }

  void editProfile(ProfileData newProfileData) {
    _user = User(
      userId: _user.userId,
      username: _user.username,
      email: _user.email,
      password: _user.password,
      favorites: _user.favorites,
      inventoryCards: _user.inventoryCards,
      onChange: _user.onChange,
      balance: _user.balance,
      avatarUrl: _user.avatarUrl,
      achievements: _user.achievements,
      favoritesAchievements: _user.favoritesAchievements,
      notifications: _user.notifications,
      profileData: newProfileData,
    );
  }
} 