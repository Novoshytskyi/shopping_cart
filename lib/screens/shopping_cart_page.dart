import 'package:flutter/material.dart';
import 'package:shopping_cart/model/shopping_cart.dart';
import '../constants.dart';
import '../db/database.dart';
import '../functions.dart';
import '../model/user.dart';
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
  int id = 1;

  @override
  void initState() {
    super.initState();
    updateCurrentUserId();

    debugColorPrint('shopping_cart_page -> Открыт');
  }

  Future<void> updateCurrentUserId() async {
    User? currentUser = await UserSecureStorage.getCurrentUserInfo();
    currentUserId = currentUser?.id;

    setState(() {
      id = int.parse(currentUserId.toString());
    });

    debugColorPrint('1. shopping_cart_page -> currentUserId: $currentUserId');
  }

  @override
  Widget build(BuildContext context) {
    debugColorPrint('2. shopping_cart_page -> currentUserId: $currentUserId');
    late Future<List<ShoppingCart>>? cartsList;

    cartsList = DBProvider.db.getProductsInShoppingCart(userId: id);

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
                future: cartsList, //!
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return NewListView(
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
                  // print(_cartsList);
                  return const CircularProgressIndicator();
                },
              ),
            ),
            ReusableButton(
              text: 'СДЕЛАТЬ ЗАКАЗ',
              onPressed: () {
                //todo: проверить таблицу на пустоту
                // if (productsInShoppingCart.isNotEmpty) {

                showCustomSnackBar(
                  context,
                  'Заказ принят',
                );

                // Очистка таблицы ShoppingCart текущего пользователя.
                DBProvider.db
                    .deleteAllProductsFromShoppingCart(userId: currentUserId!);

                setState(() {});

                // } else {
                //   showCustomSnackBar(
                //     context,
                //     'Коризна пуста',
                //   );
                //   playSound();
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
