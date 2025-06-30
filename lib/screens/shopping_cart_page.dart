import 'package:flutter/material.dart';
import '../constants.dart';
import '../functions.dart';
import '../theme_settings.dart';
import '../widgets/list_view.dart';
import '../widgets/reusable_button.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});
  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appBarShoppingCartText,
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
                message: shoppingCartSnackBarText,
                onPressed: () {
                  playSound();
                  setState(() {});
                },
                action: ActionIconType.remove,
              ),
            ),
            ReusableButton(
              text: makeOrderButtonText,
              onPressed: () {
                if (productsInShoppingCart.isNotEmpty) {
                  showCustomSnackBar(
                    context,
                    orderCompletedSnackBarText,
                  );
                  productsInShoppingCart.clear();
                  playSound();
                  setState(() {});
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
