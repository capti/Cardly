import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../controllers/auth_controller.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  final String tempToken;
  
  const EmailVerificationScreen({
    super.key,
    required this.email,
    required this.tempToken,
  });

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
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

  Future<void> _verifyEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        await Provider.of<AuthController>(context, listen: false)
            .verifyEmail(widget.tempToken, _codeController.text.trim(), context: context);

      } catch (e) {
        if (!mounted) return;

        final errorText = e.toString().replaceAll('Exception: ', '');
        
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

  void _resendCode() async {
    if (_resendTimeLeft == 0) {
      try {
        await Provider.of<AuthController>(context, listen: false)
            .resendActivationCode(widget.email, context: context);
        
        // Запускаем таймер заново после успешной отправки
        _startResendTimer();
      } catch (e) {
        if (!mounted) return;
        
        final errorText = e.toString().replaceAll('Exception: ', '');
        
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

  String _obscureEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    
    final name = parts[0];
    final domain = parts[1];
    
    final obscuredName = name.length > 2 
        ? '${name.substring(0, 2)}${'*' * (name.length - 2)}'
        : name;
    
    return '$obscuredName@$domain';
  }

  String _formatTimeLeft(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final isLoading = authController.isLoading;
    final obscuredEmail = _obscureEmail(widget.email);
    
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      body: Column(
        children: [
          const SizedBox(height: 80),
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
              fontFamily: 'Jost',
            ),
          ),
          const SizedBox(height: 30),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Подтверждение электронной почты',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF000000),
                  fontFamily: 'Jost',
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
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Jost',
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _codeController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEAD7C3),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        labelStyle: TextStyle(fontFamily: 'Jost'),
                        hintStyle: TextStyle(fontFamily: 'Jost'),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пожалуйста, введите код';
                        }
                        if (value.length != 6) {
                          return 'Код должен состоять из 6 цифр';
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
                          style: TextStyle(
                            fontSize: 14,
                            color: _resendTimeLeft > 0 ? Colors.grey : Colors.black,
                            fontFamily: 'Jost',
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 100),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _verifyEmail,
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
                                fontFamily: 'Roboto',
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 