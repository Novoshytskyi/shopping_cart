import 'package:flutter/material.dart';

import 'model/product.dart';
import 'theme_settings.dart';

Icon shoppingCartIcon = const Icon(
  Icons.shopping_cart_outlined,
  size: 24.0,
  color: lightColor,
);

Icon deleteIcon = const Icon(
  Icons.delete_outline,
  size: 24.0,
  color: lightColor,
);

List<Product> productsInShoppingCart = []; //TODO: Закомментировать!
