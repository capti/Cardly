import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/card_model.dart';
import '../models/shop_model.dart';
import '../models/theme_model.dart' as app_theme;
import '../models/achievement_model.dart';
import '../models/news_model.dart';
import '../models/quest_model.dart';
import '../models/notification_model.dart';
import '../models/trade_model.dart';

class ApiService {
  static const String baseUrl = 'http://217.114.7.39:8080/api';
  static const String loginUrl = '$baseUrl/auth/login';
  static const String registerUrl = '$baseUrl/auth/register';
  static const String activateUrl = '$baseUrl/auth/verify';
  static const String resendActivationUrl = '$baseUrl/auth/resend-code';
  static const String forgotPasswordUrl = '$baseUrl/auth/forgot-password';
  static const String resetPasswordUrl = '$baseUrl/auth/reset-password';
  
  // Карты
  static const String cardsUrl = '$baseUrl/cards';
  static const String shopUrl = '$baseUrl/shop';

  Future<Map<String, String>> getHeaders() async {
    final token = await getSavedToken();
    final headers = {
      'Content-Type': 'application/json',
    };
    
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    return headers;
  }
  

  Future<UserModel> login(String email, String password) async {
    try {
      print('Отправка запроса на авторизацию: $loginUrl');
      print('Данные запроса: email=$email, password=${password.replaceAll(RegExp(r'.'), '*')}');
      
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      print('Получен ответ от сервера: ${response.statusCode}');
      print('Тело ответа: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final userModel = UserModel.fromJson(responseData);
        
        if (userModel.token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', userModel.token!);
          print('Токен успешно сохранен');
        }
        
        print('Пользователь успешно авторизован: ${userModel.email} (${userModel.username ?? 'без имени'})');
        return userModel;
      } else {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['message'] ?? 'Ошибка авторизации. Попробуйте снова.';
        print('Ошибка авторизации: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Критическая ошибка при авторизации: ${e.toString()}');
      throw Exception('Ошибка сети: ${e.toString()}');
    }
  }
  
  Future<Map<String, dynamic>> register(String email, String username, String password) async {
    try {
      print('Отправка запроса на регистрацию: $registerUrl');
      print('Данные запроса: email=$email, username=$username, password=${password.replaceAll(RegExp(r'.'), '*')}');
      
      final response = await http.post(
        Uri.parse(registerUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'username': username,
          'password': password,
        }),
      );

      print('Получен ответ от сервера: ${response.statusCode}');
      print('Тело ответа: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final tempToken = responseData['tempToken'];
        final message = responseData['message'] ?? 'Пользователь успешно зарегистрирован';
        
        print('Результат регистрации: $message (tempToken: $tempToken)');
        return responseData;
      } else {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['message'] ?? 'Ошибка регистрации. Попробуйте снова.';
        print('Ошибка регистрации: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Критическая ошибка при регистрации: ${e.toString()}');
      throw Exception('Ошибка сети: ${e.toString()}');
    }
  }
  
 
  Future<String?> getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
  
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
  
  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
  
  Future<UserModel> activateAccount(String tempToken, String code) async {
    try {
      print('Отправка запроса на активацию аккаунта: $activateUrl');
      print('Данные запроса: tempToken=$tempToken, code=$code');
      
      final headers = await getHeaders();
      headers['Content-Type'] = 'application/json';
      
      final response = await http.post(
        Uri.parse(activateUrl),
        headers: headers,
        body: json.encode({
          'tempToken': tempToken,
          'code': code,
        }),
      );

      print('Получен ответ от сервера: ${response.statusCode}');
      print('Тело ответа: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final userModel = UserModel.fromJson(responseData);
        
        if (userModel.token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', userModel.token!);
          print('Токен успешно сохранен');
        }
        
        print('Аккаунт успешно активирован для: ${userModel.email}');
        return userModel;
      } else {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['message'] ?? 'Ошибка активации аккаунта. Попробуйте снова.';
        print('Ошибка активации аккаунта: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Критическая ошибка при активации аккаунта: ${e.toString()}');
      throw Exception('Ошибка сети: ${e.toString()}');
    }
  }
  
  Future<bool> resendActivationCode(String email) async {
    try {
      print('Отправка запроса на повторную отправку кода: $resendActivationUrl');
      print('Данные запроса: email=$email');
      
      final headers = await getHeaders();
      headers['Content-Type'] = 'application/json';
      
      final response = await http.post(
        Uri.parse(resendActivationUrl),
        headers: headers,
        body: json.encode({
          'email': email,
        }),
      );

      print('Получен ответ от сервера: ${response.statusCode}');
      print('Тело ответа: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final success = responseData['success'] ?? false;
        final message = responseData['message'] ?? 'Код активации отправлен повторно';
        
        print('Результат отправки кода: $message (успех: $success)');
        return success;
      } else {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['message'] ?? 'Ошибка отправки кода. Попробуйте снова.';
        print('Ошибка отправки кода: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Критическая ошибка при отправке кода: ${e.toString()}');
      throw Exception('Ошибка сети: ${e.toString()}');
    }
  }
  
  Future<bool> forgotPassword(String email) async {
    try {
      print('Отправка запроса на сброс пароля: $forgotPasswordUrl');
      print('Данные запроса: email=$email');
      
      final response = await http.post(
        Uri.parse(forgotPasswordUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
        }),
      );

      print('Получен ответ от сервера: ${response.statusCode}');
      print('Тело ответа: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final success = responseData['success'] ?? false;
        final message = responseData['message'] ?? 'Инструкции по сбросу пароля отправлены';
        
        print('Результат запроса на сброс пароля: $message (успех: $success)');
        return success;
      } else {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['message'] ?? 'Ошибка при запросе сброса пароля. Попробуйте снова.';
        print('Ошибка запроса сброса пароля: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Критическая ошибка при запросе сброса пароля: ${e.toString()}');
      throw Exception('Ошибка сети: ${e.toString()}');
    }
  }
  
  Future<bool> resetPassword(String token, String newPassword) async {
    try {
      print('НАЧАЛО ПРОЦЕССА СБРОСА ПАРОЛЯ');
      print('URL запроса: $resetPasswordUrl');
      print('Параметры запроса:');
      print('- token: $token');
      print('- newPassword: $newPassword');
      
      final requestBody = {
        'token': token,
        'newPassword': newPassword,
      };
      print('Тело запроса (JSON): ${json.encode(requestBody)}');
      
      print('Отправка HTTP POST запроса...');
      final response = await http.post(
        Uri.parse(resetPasswordUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      print('\nПолучен ответ от сервера:');
      print('Статус код: ${response.statusCode}');
      print('Заголовки ответа: ${response.headers}');
      print('Тело ответа: ${response.body}');

      if (response.statusCode == 200) {
        print('\nУспешный статус код (200). Парсинг ответа...');
        final responseData = json.decode(response.body);
        final success = responseData['success'] ?? false;
        final message = responseData['message'] ?? 'Пароль успешно изменен';
        
        print('Результат парсинга:');
        print('- success: $success');
        print('- message: $message');
        
        print('\nРезультат операции сброса пароля:');
        print('- Успех: $success');
        print('- Сообщение: $message');
        print('=== КОНЕЦ ПРОЦЕССА СБРОСА ПАРОЛЯ ===\n');
        
        return success;
      } else {
        print('\nПолучен код ошибки: ${response.statusCode}');
        final errorData = json.decode(response.body);
        final errorMessage = errorData['message'] ?? 'Ошибка при восстановлении пароля. Попробуйте снова.';
        
        print('Данные об ошибке:');
        print('- Сообщение: $errorMessage');
        print('- Полное тело ответа: ${response.body}');
        print('=== КОНЕЦ ПРОЦЕССА СБРОСА ПАРОЛЯ (С ОШИБКОЙ) ===\n');
        
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('\n!!! КРИТИЧЕСКАЯ ОШИБКА ПРИ СБРОСЕ ПАРОЛЯ !!!');
      print('Тип ошибки: ${e.runtimeType}');
      print('Сообщение ошибки: ${e.toString()}');
      print('Стек вызовов:');
      print(StackTrace.current);
      print('=== КОНЕЦ ПРОЦЕССА СБРОСА ПАРОЛЯ (С КРИТИЧЕСКОЙ ОШИБКОЙ) ===\n');
      
      throw Exception('Ошибка сети: ${e.toString()}');
    }
  }

  // Карты
  Future<List<CardModel>> getUserInventory({String sortBy = 'rarity'}) async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('$cardsUrl/inventory?sortBy=$sortBy'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => CardModel.fromJson(json)).toList();
      } else {
        throw Exception('Ошибка при получении инвентаря: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<CardModel> getCardDetails(int cardId) async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('$cardsUrl/$cardId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return CardModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Ошибка при получении деталей карты: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<int> disassembleCard(int cardId) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$cardsUrl/$cardId/disassemble'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['coinsReceived'] as int;
      } else {
        throw Exception('Ошибка при разборе карты: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  // Магазин
  Future<List<Pack>> getAllPacks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/shop/packs'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Pack.fromJson(json)).toList();
      } else {
        throw Exception('Ошибка при получении списка наборов: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<Pack> getPackDetails(int packId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/shop/packs/$packId'),
      );

      if (response.statusCode == 200) {
        return Pack.fromJson(json.decode(response.body));
      } else {
        throw Exception('Ошибка при получении деталей набора: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<Map<String, dynamic>> buyPack(int packId) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/shop/packs/$packId/buy'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 402) {
        final error = json.decode(response.body);
        throw Exception('Недостаточно средств. Требуется: ${error['requiredAmount']}');
      } else {
        throw Exception('Ошибка при покупке набора: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<Map<String, dynamic>> openPack(int packId) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/shop/packs/$packId/open'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Ошибка при открытии набора: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<List<CoinOffer>> getCoinOffers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/shop/coins/offers'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => CoinOffer.fromJson(json)).toList();
      } else {
        throw Exception('Ошибка при получении предложений монет: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<CoinOffer> getCoinOfferDetails(int offerId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/shop/coins/offers/$offerId'),
      );

      if (response.statusCode == 200) {
        return CoinOffer.fromJson(json.decode(response.body));
      } else {
        throw Exception('Ошибка при получении деталей предложения: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<String> purchaseCoins(int offerId, String redirectUrl) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/shop/coins/offers/$offerId/purchase'),
        headers: headers,
        body: json.encode({'redirectUrl': redirectUrl}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['paymentUrl'];
      } else {
        throw Exception('Ошибка при покупке монет: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  // Генерация карт
  Future<List<app_theme.Theme>> getCardGenerationThemes() async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/home/generate-card/themes'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => app_theme.Theme.fromJson(json)).toList();
      } else {
        throw Exception('Ошибка при получении тем: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<Map<String, dynamic>> generateCard(int themeId) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/home/generate-card'),
        headers: headers,
        body: json.encode({'theme_ID': themeId}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 402) {
        final error = json.decode(response.body);
        throw Exception('Недостаточно средств. Требуется: ${error['requiredAmount']}');
      } else {
        throw Exception('Ошибка при генерации карты: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  // Профиль
  Future<Map<String, dynamic>> getProfile() async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/profile'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Ошибка при получении профиля: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<List<Achievement>> getAchievements() async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/profile/achievements'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['achievements'] as List)
            .map((json) => Achievement.fromJson(json))
            .toList();
      } else {
        throw Exception('Ошибка при получении достижений: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<bool> addAchievementToFavorites(int achievementId) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/profile/achievements/$achievementId/favorite-add'),
        headers: headers,
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<bool> removeAchievementFromFavorites(int achievementId) async {
    try {
      final headers = await getHeaders();
      final response = await http.delete(
        Uri.parse('$baseUrl/profile/achievements/$achievementId/favorite-delete'),
        headers: headers,
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<Map<String, dynamic>> getProfileSettings() async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/profile/settings'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Ошибка при получении настроек: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<Map<String, dynamic>> updateProfileSettings(Map<String, dynamic> settings) async {
    try {
      final headers = await getHeaders();
      final response = await http.put(
        Uri.parse('$baseUrl/profile/settings-change'),
        headers: headers,
        body: json.encode(settings),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Ошибка при обновлении настроек: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  // Другие профили
  Future<Map<String, dynamic>> getOtherProfile(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/other-profile/$userId'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Ошибка при получении профиля: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<List<Achievement>> getOtherProfileAchievements(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/other-profile/$userId/achievements'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['achievements'] as List)
            .map((json) => Achievement.fromJson(json))
            .toList();
      } else {
        throw Exception('Ошибка при получении достижений: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<Map<String, dynamic>> getOtherProfileInventory(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/other-profile/$userId/inventory'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 403) {
        throw Exception('Инвентарь скрыт');
      } else {
        throw Exception('Ошибка при получении инвентаря: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<bool> reportUser(int userId, String reason, {String? comment}) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/other-profile/$userId/report'),
        headers: headers,
        body: json.encode({
          'reason': reason,
          if (comment != null) 'comment': comment,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  // Новости
  Future<List<News>> getNews() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/home/news'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => News.fromJson(json)).toList();
      } else {
        throw Exception('Ошибка при получении новостей: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<News> getNewsDetails(int newsId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/home/news/$newsId'));

      if (response.statusCode == 200) {
        return News.fromJson(json.decode(response.body));
      } else {
        throw Exception('Ошибка при получении новости: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  // Квесты
  Future<Map<String, List<Quest>>> getQuests() async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/home/quests'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'dailyQuests': (data['dailyQuests'] as List)
              .map((json) => Quest.fromJson(json))
              .toList(),
          'weeklyQuests': (data['weeklyQuests'] as List)
              .map((json) => Quest.fromJson(json))
              .toList(),
        };
      } else {
        throw Exception('Ошибка при получении квестов: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<Quest> changeQuestStatus(int questId) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/home/quests/$questId/change-status'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Quest.fromJson(data['quest']);
      } else {
        throw Exception('Ошибка при изменении статуса квеста: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<Map<String, dynamic>> claimQuestReward(String questType) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/home/quests/claim-reward'),
        headers: headers,
        body: json.encode({'questType': questType}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Ошибка при получении награды: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  // Уведомления
  Future<List<Notification>> getNotifications() async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/home/notifications'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Notification.fromJson(json)).toList();
      } else {
        throw Exception('Ошибка при получении уведомлений: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<Notification> getNotificationDetails(int notificationId) async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/home/notifications/$notificationId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return Notification.fromJson(json.decode(response.body));
      } else {
        throw Exception('Ошибка при получении уведомления: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<String> navigateToNotification(int notificationId) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/home/notifications/$notificationId/navigate'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['redirectUrl'];
      } else {
        throw Exception('Ошибка при переходе по уведомлению: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  // Обмен картами
  Future<List<Trade>> getAllTrades({String? search}) async {
    try {
      String url = '$baseUrl/trades';
      if (search != null && search.isNotEmpty) {
        url += '?search=$search';
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Trade.fromJson(json)).toList();
      } else {
        throw Exception('Ошибка при получении списка обменов: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<Trade> getTradeDetails(int tradeId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/trades/$tradeId'),
      );

      if (response.statusCode == 200) {
        return Trade.fromJson(json.decode(response.body));
      } else {
        throw Exception('Ошибка при получении деталей обмена: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<Trade> initiateTrade(int offeredCardId, List<int> requestedCardIds) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/trades/initiate'),
        headers: headers,
        body: json.encode({
          'offeredCardId': offeredCardId,
          'requestedCardId': requestedCardIds,
        }),
      );

      if (response.statusCode == 201) {
        return Trade.fromJson(json.decode(response.body));
      } else {
        throw Exception('Ошибка при создании обмена: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<List<Trade>> getMyTrades() async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/trades/my'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Trade.fromJson(json)).toList();
      } else {
        throw Exception('Ошибка при получении моих обменов: ${response.body}');
      }
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<bool> acceptTrade(int tradeId) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/trades/$tradeId/accept'),
        headers: headers,
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<bool> rejectTrade(int tradeId) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/trades/$tradeId/reject'),
        headers: headers,
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }

  Future<bool> cancelTrade(int tradeId) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/trades/$tradeId/cancel'),
        headers: headers,
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Ошибка сети: $e');
    }
  }
} 