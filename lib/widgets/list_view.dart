import 'package:flutter/material.dart';
import '../model/product.dart';
import '../constants.dart';
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

  final List<Product> products;
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
        onPressed: () {
          if (action == ActionIconType.add) {
            productsInShoppingCart.add(products[index]);
          }
          if (action == ActionIconType.remove) {
            productsInShoppingCart.remove(products[index]);
          }
          onPressed!();
        },
      ),
    );
  }
}
