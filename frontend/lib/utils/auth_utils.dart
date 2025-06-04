import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../views/authorization_dialog.dart';
import 'package:provider/provider.dart';

class AuthUtils {
  static bool isGuestAllowedScreen(String screenName) {
    final allowedScreens = {
      'home_screen': true,
      'news_screen': true,
      'news_detail_screen': true,
      'exchanges_screen': true,
      'exchange_details_screen': true,
      'shop_screen': true,
      'search_players_screen': true,
      'card_detail_screen': true,
      // Защищенные экраны
      'profile_screen': false,
      'inventory_screen': false,
      'create_exchange_screen': false,
      'my_exchanges_screen': false,
      'create_card_screen': false,
      'achievements_screen': false,
      'settings_screen': false,
      'notifications_screen': false,
      'quests_screen': false,
    };
    return allowedScreens[screenName] ?? false;
  }

  static bool checkGuestAccess(BuildContext context, String screenName) {
    final authController = Provider.of<AuthController>(context, listen: false);
    final isGuest = authController.currentUser?.isGuest ?? false;

    if (isGuest && !isGuestAllowedScreen(screenName)) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => const AuthorizationDialog(),
      );
      return false;
    }
    return true;
  }
} 