import 'package:flutter/material.dart';
import '../constants.dart';
import '../db/database.dart';
import '../functions.dart';
import '../theme_settings.dart';
import '../user_secure_storage.dart';
import '../widgets/list_view.dart';
import '../widgets/reusable_button.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});
  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  int? currentUserId;

  updateCurrentUserId() async {
    currentUserId = await UserSecureStorage.getCurrentUserId();
  }

  @override
  void initState() {
    super.initState();
    updateCurrentUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'КОРЗИНА',
          style: TextStyle(
            color: richColor,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: NewListView(
                context: context,
                products: productsInShoppingCart,
                listViewIcon: deleteIcon,
                message: 'Товар удален',
                onPressed: () {
                  playSound();
                  setState(() {});
                },
                action: ActionIconType.remove,
              ),
            ),
            ReusableButton(
              text: 'СДЕЛАТЬ ЗАКАЗ',
              onPressed: () {
                if (productsInShoppingCart.isNotEmpty) {
                  showCustomSnackBar(
                    context,
                    'Заказ принят',
                  );
                  productsInShoppingCart.clear(); //TODO: Закомментировать!

                  // Очистка таблицы ShoppingCart текущего пользователя.
                  if (currentUserId != null) {
                    DBProvider.db.deleteAllProductsFromShoppingCart(
                        userId: currentUserId!);
                  }

                  setState(() {});
                } else {
                  showCustomSnackBar(
                    context,
                    'Коризна пуста',
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
