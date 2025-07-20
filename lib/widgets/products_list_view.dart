import 'package:flutter/material.dart';
import 'package:shopping_cart/model/shopping_cart.dart';
import '../db/database.dart';
import '../user_secure_storage.dart';
import 'product_card.dart';

enum ActionIconType {
  add,
  remove,
}

class ProductsAndShoppingCartListView extends StatelessWidget {
  const ProductsAndShoppingCartListView({
    super.key,
    required BuildContext context,
    required this.products,
    required this.listViewIcon,
    required this.message,
    required this.onPressed,
    required this.action,
  });

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
        price: products[index].price,
        image: products[index].image,
        iconRight: listViewIcon,
        message: message,
        onPressed: () async {
          int? currentUserId = await UserSecureStorage.getCurrentUserId();

          ShoppingCart shoppingCart = ShoppingCart(
            id: null,
            productId: products[index].id,
          );

          // Добавление в таблицу ShoppingCart.
          if (action == ActionIconType.add) {
            if (currentUserId != null) {
              DBProvider.db.insertProductToShoppingCart(
                shoppingCart: shoppingCart,
                userId: int.parse(currentUserId.toString()),
              );
            }
          }

          // Удаление из таблицы ShoppingCart.
          if (action == ActionIconType.remove) {
            if (currentUserId != null) {
              DBProvider.db.deleteProductFromShoppingCart(
                  productId: products[index].id, userId: currentUserId);
            }
          }
          onPressed!();
        },
      ),
    );
  }
}
