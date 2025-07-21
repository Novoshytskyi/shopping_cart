import 'package:flutter/material.dart';
import 'package:shopping_cart/screens/history_screen.dart';
import 'package:shopping_cart/screens/splash_screen.dart';
import 'package:shopping_cart/screens/users_info_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/products_screen.dart';
import 'screens/register_screen.dart';
import 'screens/shopping_cart_screen.dart';
import 'theme_settings.dart';

void main() {
  runApp(const Shopping());
}

class Shopping extends StatelessWidget {
  const Shopping({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: customThemeSettings,
      title: 'Shopping',
      routes: <String, WidgetBuilder>{
        '/page1': (context) => const AuthScreen(),
        '/page2': (context) => const RegisterScreen(),
        '/page3': (context) => const ProductsScreen(),
        '/page4': (context) => const ShoppingCartScreen(),
        '/page5': (context) => const UsersInfoScreen(),
        '/page6': (context) => const HistoryScreen(),
        '/page7': (context) => const SplashScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
