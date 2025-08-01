import 'package:flutter/material.dart';
import '../constants.dart';
import '../db/database.dart';
import '../functions.dart';
import '../model/product_in_shopping_cart.dart';
import '../model/user.dart';
import '../theme_settings.dart';
import '../widgets/products_list_view.dart';
import '../widgets/reusable_button.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});
  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = ModalRoute.of(context)!.settings.arguments as User;
    int id = int.parse(currentUser.id.toString());

    late Future<List<ProductInShoppingCart>>? cartsList;

    cartsList = DBProvider.db.getProductsInShoppingCart(userId: id);

    bool shoppingCarthasProducts = false;

    void checkingShoppingCartIsNotEmpty() async {
      shoppingCarthasProducts =
          await DBProvider.db.shoppingCartIsNotEmpty(userId: id);
    }

    checkingShoppingCartIsNotEmpty();

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
              child: FutureBuilder(
                future: cartsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ProductsAndShoppingCartListView(
                      context: context,
                      products: snapshot.data!,
                      listViewIcon: deleteIcon,
                      message: 'Товар удален',
                      onPressed: () {
                        setState(() {});
                      },
                      action: ActionIconType.remove,
                    );
                  }
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Text('Данные товаров в корзине не найденны.');
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ),
            ReusableButton(
              text: 'СДЕЛАТЬ ЗАКАЗ',
              onPressed: () {
                DBProvider.db.shoppingCartIsNotEmpty(userId: id);

                if (shoppingCarthasProducts) {
                  showCustomSnackBar(
                    context,
                    'Заказ принят',
                  );

                  // Добавление в таблицу History данных из таблицы. ShoppingCart пользователя
                  DBProvider.db.addShoppingCartToHistory(userId: id);

                  // Очистка таблицы ShoppingCart текущего пользователя.
                  DBProvider.db.deleteAllProductsFromShoppingCart(userId: id);

                  setState(() {});
                } else {
                  showCustomSnackBar(
                    context,
                    'Коризна пуста',
                  );
                  playSound();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
