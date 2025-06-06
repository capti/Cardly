import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'services/analytics_service.dart';
import 'views/splash_screen.dart';
import 'views/auth_screen.dart';
import 'views/email_verification_screen.dart';
import 'views/forgot_password_screen.dart';
import 'views/change_password_screen.dart';
import 'views/home_screen.dart';
import 'views/inventory_screen.dart';
import 'views/shop_screen.dart';
import 'views/exchanges_screen.dart';
import 'utils/auth_utils.dart';
import 'views/authorization_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AnalyticsService.initialize();
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
        home: Builder(
          builder: (context) {
            return FutureBuilder<bool>(
              future: Provider.of<AuthController>(context, listen: false).tryAutoLogin(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                }
                if (snapshot.hasError) {
                  return const AuthScreen();
                }
                return snapshot.data == true ? const MainScreen() : const AuthScreen();
              },
            );
          },
        ),
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

class MainScreen extends StatefulWidget {
  final int? initialIndex;
  final String? notification;
  
  const MainScreen({
    super.key,
    this.initialIndex,
    this.notification,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _pageController.jumpToPage(_currentIndex);
        // Track initial screen view
        AnalyticsService.trackScreenView(_screenNames[_currentIndex]);
        if (widget.notification != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Container(
                width: 367,
                height: 61,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAD7C3),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: Center(
                  child: Text(
                    widget.notification!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Jost',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              duration: const Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 200,
                left: 16,
                right: 16,
              ),
              elevation: 0,
            ),
          );
        }
      }
    });
  }

  final List<String> _screenNames = [
    'home_screen',
    'inventory_screen',
    'shop_screen',
    'exchanges_screen',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    final authController = Provider.of<AuthController>(context, listen: false);
    if (authController.currentUser?.isGuest ?? false) {
      if (!AuthUtils.isGuestAllowedScreen(_screenNames[index])) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => const AuthorizationDialog(),
        );
        return;
      }
    }
    
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
    // Track screen view when user navigates
    AnalyticsService.trackScreenView(_screenNames[index]);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),
      const InventoryScreen(),
      const ShopScreen(),
      ExchangesScreen(initialTabIndex: _currentIndex == 3 ? 0 : null),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFD6A067),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedIconTheme: const IconThemeData(
            size: 28,
          ),
          unselectedIconTheme: const IconThemeData(
            size: 24,
          ),
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'Jost',
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontFamily: 'Jost',
          ),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/главная.png', height: 24),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDD6B0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('assets/icons/главная.png', height: 24),
              ),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/Инвентарь.png', height: 24),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDD6B0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('assets/icons/Инвентарь.png', height: 24),
              ),
              label: 'Инвентарь',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/магазин.png', height: 24),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDD6B0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('assets/icons/магазин.png', height: 24),
              ),
              label: 'Магазин',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/обменник.png', height: 24),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDD6B0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('assets/icons/обменник.png', height: 24),
              ),
              label: 'Обменник',
            ),
          ],
        ),
      ),
    );
  }
}
