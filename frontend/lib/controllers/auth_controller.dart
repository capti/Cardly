import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../views/home_screen.dart';

class AuthController with ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _token;
  final ApiService _apiService = ApiService();

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null;

  static const String _baseUrl = 'http://87.236.23.130:8080/api';
  static const String _loginUrl = '$_baseUrl/auth/login';

  static const String loginError = 'Неверный логин или пароль';
  static const String verificationError = 'Неверный код подтверждения';
  static const String networkError = 'Ошибка сети, проверьте подключение и корректность заполненной формы или кода активации.';

  String _handleError(dynamic error, String defaultMessage) {
    final errorMessage = error.toString();

    if (errorMessage.contains('401') || 
        errorMessage.contains('неверный') || 
        errorMessage.contains('incorrect') ||
        errorMessage.contains('invalid')) {
      return defaultMessage;
    }
    
    if (errorMessage.contains('сети') || 
        errorMessage.contains('network') || 
        errorMessage.contains('connection')) {
      return networkError;
    }

    return defaultMessage;
  }

  Future<void> login(String email, String password, {BuildContext? context}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final userModel = await _apiService.login(email, password);
      
      _currentUser = userModel;
      _token = userModel.token;
      
      _isLoading = false;
      notifyListeners();

      if (context != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      final errorMessage = _handleError(e, loginError);
      throw Exception(errorMessage);
    }
  }

  Future<void> register(String email, String username, String password, {BuildContext? context}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await _apiService.register(email, username, password);
      
      if (success) {
        _currentUser = UserModel(
          email: email,
          username: username,
          isEmailVerified: false,
        );
      }
      
      _isLoading = false;
      notifyListeners();

      if (context != null && success) {

      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      final errorMessage = _handleError(e, networkError);
      throw Exception(errorMessage);
    }
  }

  Future<void> verifyEmail(String email, String code, {BuildContext? context}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await _apiService.activateAccount(email, code);
      
      if (success && _currentUser != null) {
        _currentUser = UserModel(
          email: _currentUser!.email,
          username: _currentUser!.username,
          token: _currentUser!.token,
          isEmailVerified: true,
        );
      }
      
      _isLoading = false;
      notifyListeners();
      
      if (context != null && success) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email успешно подтвержден')),
        );

        if (_token == null) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      final errorMessage = _handleError(e, verificationError);
      throw Exception(errorMessage);
    }
  }

  Future<void> forgotPassword(String email, {BuildContext? context}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await _apiService.forgotPassword(email);
      
      _isLoading = false;
      notifyListeners();
      
      if (context != null && success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Инструкции по сбросу пароля отправлены на вашу почту')),
        );
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      final errorMessage = _handleError(e, networkError);
      throw Exception(errorMessage);
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    _isLoading = true;
    notifyListeners();

    try {

      await Future.delayed(const Duration(seconds: 2));
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> logout() async {
    _token = null;
    _currentUser = null;
    
    await _apiService.removeToken();
    
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final token = await _apiService.getSavedToken();
    
    if (token == null || token.isEmpty) {
      return false;
    }
    
    _token = token;

    
    notifyListeners();
    return true;
  }

  Future<void> resendActivationCode(String email, {BuildContext? context}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await _apiService.resendActivationCode(email);
      
      _isLoading = false;
      notifyListeners();
      
      if (context != null && success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Код активации отправлен повторно')),
        );
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> resetPassword(String token, String newPassword, {BuildContext? context}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await _apiService.resetPassword(token, newPassword);
      
      _isLoading = false;
      notifyListeners();
      
      if (context != null && success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Пароль успешно изменен')),
        );

        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      final errorMessage = _handleError(e, verificationError);
      throw Exception(errorMessage);
    }
  }
} 