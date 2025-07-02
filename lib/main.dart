import 'package:flutter/material.dart';
import 'package:shopping_cart/screens/users_info_page.dart';
import 'constants.dart';
import 'screens/auth_page.dart';
import 'screens/products_page.dart';
import 'screens/register_page.dart';
import 'screens/shopping_cart_page.dart';
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

      // initialRoute: '/page3',
      routes: <String, WidgetBuilder>{
        '/page1': (context) => const AuthPage(),
        '/page2': (context) => const RegisterPage(),
        '/page3': (context) => const ProductsPage(),
        '/page4': (context) => const ShoppingCartPage(),
        '/page5': (context) => const UsersInfoPage(),
      },

      home: const AuthPage(),
    );
  }
}
