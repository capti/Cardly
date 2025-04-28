import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../views/home_screen.dart';

class AuthController with ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _token;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null;

  Future<void> login(String email, String password, {BuildContext? context}) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Здесь будет API запрос к серверу
      // Имитация запроса:
      await Future.delayed(const Duration(seconds: 2));
      
      _token = 'sample_token_${DateTime.now().millisecondsSinceEpoch}';
      _currentUser = UserModel(
        id: '1',
        email: email,
        isEmailVerified: true,
      );
      

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', _token!);
      
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
      rethrow;
    }
  }

  Future<void> register(String email, String password, {BuildContext? context}) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Здесь будет API запрос к серверу
      // Имитация запроса:
      await Future.delayed(const Duration(seconds: 2));
      
      _currentUser = UserModel(
        id: '1',
        email: email,
        isEmailVerified: false,
      );
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> verifyEmail(String code) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Здесь будет API запрос к серверу
      // Имитация запроса:
      await Future.delayed(const Duration(seconds: 2));
      
      _currentUser = UserModel(
        id: _currentUser?.id ?? '1',
        email: _currentUser?.email ?? '',
        name: _currentUser?.name,
        isEmailVerified: true,
      );
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> forgotPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Здесь будет API запрос к серверу
      // Имитация запроса:
      await Future.delayed(const Duration(seconds: 2));
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Здесь будет API запрос к серверу
      // Имитация запроса:
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
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    
    notifyListeners();
  }
} 