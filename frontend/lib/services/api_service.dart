import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class ApiService {
  static const String baseUrl = 'http://87.236.23.130:8080/api';
  static const String loginUrl = '$baseUrl/auth/login';
  static const String registerUrl = '$baseUrl/auth/register';
  static const String activateUrl = '$baseUrl/auth/activate';
  static const String resendActivationUrl = '$baseUrl/auth/resend-activation-code';
  static const String forgotPasswordUrl = '$baseUrl/auth/forgot-password';
  static const String resetPasswordUrl = '$baseUrl/auth/reset-password';
  

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
  
  Future<bool> register(String email, String username, String password) async {
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
        final success = responseData['success'] ?? false;
        final message = responseData['message'] ?? 'Пользователь успешно зарегистрирован';
        
        print('Результат регистрации: $message (успех: $success)');
        return success;
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
  
  Future<bool> activateAccount(String email, String code) async {
    try {
      print('Отправка запроса на активацию аккаунта: $activateUrl');
      print('Данные запроса: email=$email, code=$code');
      
      final response = await http.post(
        Uri.parse(activateUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'code': code,
        }),
      );

      print('Получен ответ от сервера: ${response.statusCode}');
      print('Тело ответа: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final success = responseData['success'] ?? false;
        final message = responseData['message'] ?? 'Операция выполнена успешно';
        
        print('Результат активации: $message (успех: $success)');
        return success;
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
      
      final response = await http.post(
        Uri.parse(resendActivationUrl),
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
} 