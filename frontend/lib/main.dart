import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'views/splash_screen.dart';
import 'views/auth_screen.dart';
import 'views/email_verification_screen.dart';
import 'views/forgot_password_screen.dart';
import 'views/change_password_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: MaterialApp(
        title: 'Cardly',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFD9A76A),
            primary: const Color(0xFFD9A76A),
            background: const Color(0xFFFFF4E3),
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: const Color(0xFFFFF4E3),
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD9A76A),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFD9A76A),
              textStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              textStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFFFF4E3),
            foregroundColor: Color(0xFF000000),
            elevation: 0,
          ),
        ),
        home: const SplashScreen(),
        routes: {
          '/auth': (context) => const AuthScreen(),
          '/login': (context) => const AuthScreen(initialTabIndex: 0),
          '/register': (context) => const AuthScreen(initialTabIndex: 1),
          '/forgot-password': (context) => const ForgotPasswordScreen(),
          '/change-password': (context) => const ChangePasswordScreen(),
        },
      ),
    );
  }
}
