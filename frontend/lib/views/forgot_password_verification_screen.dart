import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../controllers/auth_controller.dart';
import 'change_password_screen.dart';

class ForgotPasswordVerificationScreen extends StatefulWidget {
  final String email;
  
  const ForgotPasswordVerificationScreen({
    super.key,
    required this.email,
  });

  @override
  State<ForgotPasswordVerificationScreen> createState() => _ForgotPasswordVerificationScreenState();
}

class _ForgotPasswordVerificationScreenState extends State<ForgotPasswordVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  int _resendTimeLeft = 3600;
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }
  
  void _startResendTimer() {
    _timer?.cancel();
    setState(() {
      _resendTimeLeft = 3600;
    });
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimeLeft > 0) {
        setState(() {
          _resendTimeLeft--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _verifyCode() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Пока оставляем задержку для имитации запроса
        await Future.delayed(const Duration(seconds: 1));
        
        if (!mounted) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangePasswordScreen(
              resetToken: _codeController.text,
              email: widget.email,
            ),
          ),
        );
      } catch (e) {
        if (!mounted) return;
        
        // Получаем текст ошибки без "Exception: "
        final errorText = e.toString().replaceAll('', '');
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorText.isEmpty ? 'Неверный код подтверждения' : errorText),
            backgroundColor: Colors.red.shade800,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    }
  }

  void _resendCode() {
    if (_resendTimeLeft == 0) {
      try {
        Provider.of<AuthController>(context, listen: false)
            .forgotPassword(widget.email);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Код отправлен повторно'),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        
        _startResendTimer();
      } catch (e) {
        // Получаем текст ошибки без "Exception: "
        final errorText = e.toString().replaceAll('', '');
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorText),
            backgroundColor: Colors.red.shade800,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final isLoading = authController.isLoading;
    final obscuredEmail = _obscureEmail(widget.email);
    
    return Scaffold(

      body: Column(
        children: [
          const SizedBox(height: 40),
          Image.asset(
            'assets/icons/карты.png',
            height: 80,
            color: const Color(0xFFD9A76A),
          ),
          const SizedBox(height: 10),
          const Text(
            'Cardly',
            style: TextStyle(
              fontSize: 32,
              color: Color(0xFFD9A76A),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Подтверждение сброса пароля',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF000000),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 60),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Введите код подтверждения,\nотправленный на $obscuredEmail',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _codeController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEDD6B0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пожалуйста, введите код';
                        }
                        return null;
                      },
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _resendTimeLeft == 0 ? _resendCode : null,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          _resendTimeLeft > 0
                              ? 'Отправить код заново (${_formatTimeLeft(_resendTimeLeft)})'
                              : 'Отправить код заново',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                            decorationThickness: 1.5,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _verifyCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD6A067),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          disabledBackgroundColor: const Color(0xFFD6A067).withOpacity(0.7),
                        ),
                        child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.black,
                              ),
                            )
                          : const Text(
                              'Подтвердить',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD6A067),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Назад',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            width: 100,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
  
  String _obscureEmail(String email) {
    if (email.isEmpty) return '';
    
    final parts = email.split('@');
    if (parts.length != 2) return email;
    
    String username = parts[0];
    String domain = parts[1];
    
    if (username.length <= 4) {
      return '*' * username.length + '@' + domain;
    } else {
      return username.substring(0, 4) + '*' * (username.length - 4) + '@' + domain;
    }
  }

  String _formatTimeLeft(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
} 