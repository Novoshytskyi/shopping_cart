import 'package:flutter/material.dart';
import 'package:shopping_cart/functions.dart';
import 'package:shopping_cart/model/shopping_cart.dart';
import '../db/database.dart';
import '../user_secure_storage.dart';
import 'product_card.dart';

enum ActionIconType {
  add,
  remove,
}

class NewListView extends StatelessWidget {
  const NewListView({
    super.key,
    required BuildContext context,
    required this.products,
    required this.listViewIcon,
    required this.message,
    required this.onPressed,
    required this.action,
  });

  // final List<Product> products;
  final List products;
  final Icon listViewIcon;
  final String message;
  final Function? onPressed;
  final ActionIconType action;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => ProductCard(
        id: products[index].id,
        name: products[index].name,
        price: products[index].price, //! ???
        image: products[index].image,
        iconRight: listViewIcon,
        message: message,
        onPressed: () async {
          int? currentUserId = await UserSecureStorage.getCurrentUserId();
          debugColorPrint('currentUserId: $currentUserId');

          // ShoppingCart shoppingCart = ShoppingCart(
          //   id: null,
          //   productId: products[index].id,
          // );

          ShoppingCart shoppingCart = ShoppingCart(
            id: products[index].id,
            name: products[index].name,
            price: products[index].price,
            image: products[index].image,
          );

          // Добавление в таблицу ShoppingCart.
          if (action == ActionIconType.add) {
            if (currentUserId != null) {
              DBProvider.db.insertProductToShoppingCart(
                shoppingCart: shoppingCart,
                userId: int.parse(currentUserId.toString()),
              );
              debugColorPrint(
                  'добавлен продукт id: ${products[index].id}, пользователь id: $currentUserId');

              debugColorPrint('Индекс (index) при добавлении продукта: $index');
            }
          }

          // Удаление из таблицы ShoppingCart.
          if (action == ActionIconType.remove) {
            if (currentUserId != null) {
              debugColorPrint('Проверка:');

              debugColorPrint('index: $index');

              DBProvider.db.deleteProductFromShoppingCart(
                  productId: shoppingCart.id as int, userId: currentUserId);
            }
          }
          onPressed!();
        },
      ),
    );
  }
}
