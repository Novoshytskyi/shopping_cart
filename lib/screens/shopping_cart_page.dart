import 'package:flutter/material.dart';
import 'package:shopping_cart/model/shopping_cart.dart';
import '../constants.dart';
import '../db/database.dart';
import '../functions.dart';
import '../model/product.dart';
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
  late Future<List<Product>> _productsList;
  late Future<List<ShoppingCart>> _cartsList;

  @override
  void initState() {
    super.initState();
    updateCurrentUserId();

    // updateProductsInShoppingCartList();

    debugColorPrint('shopping_cart_page -> Открыт');
  }

  // Future<void> updateCurrentUserId() async {
  //   currentUserId = await UserSecureStorage.getCurrentUserId();
  //   debugColorPrint('shopping_cart_page -> currentUserId: $currentUserId');
  // }
  void updateCurrentUserId() async {
    _productsList = DBProvider.db.getProducts();

    currentUserId = await UserSecureStorage.getCurrentUserId();
    debugColorPrint('1. shopping_cart_page -> currentUserId: $currentUserId');

    _cartsList =
        DBProvider.db.getProductsInShoppingCart(userId: currentUserId!);
    //--------------------------------

    debugColorPrint('2. shopping_cart_page -> currentUserId: $currentUserId');

    debugColorPrint(_cartsList.toString());
  }

  // void updateProductsInShoppingCartList() async {
  //   _productsList = DBProvider.db.getProducts();
  //   _cartsList = DBProvider.db.getProductsInShoppingCart(userId: 1);

  //   debugColorPrint(
  //       'shopping_cart_page -> перед -> currentUserId: $currentUserId');

  //   debugColorPrint(_cartsList.toString());
  // }

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
            const Divider(
              height: 2.0,
              color: richColor,
              thickness: 2.0,
            ),
            //?+++++++++++++++++++++++++++++++++++++++++++++++++
            Expanded(
              child: FutureBuilder(
                future: _productsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return NewListView(
                      context: context,
                      products: snapshot.data!,
                      listViewIcon: shoppingCartIcon,
                      message: 'Добавлен в корзину',
                      onPressed: () {
                        setState(() {});
                      },
                      action: ActionIconType.add,
                    );
                  }
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Text('Данные Продуктов не найденны.');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
            //?+++++++++++++++++++++++++++++++++++++++++++++++++
            const Divider(
              height: 2.0,
              color: richColor,
              thickness: 2.0,
            ),
            //?+++++++++++++++++++++++++++++++++++++++++++++++++

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
            //?+++++++++++++++++++++++++++++++++++++++++++++++++
            const Divider(
              height: 2.0,
              color: richColor,
              thickness: 2.0,
            ),
            //?+++++++++++++++++++++++++++++++++++++++++++++++++
            const Expanded(child: SizedBox(height: 10.0)),
            //?+++++++++++++++++++++++++++++++++++++++++++++++++

            ReusableButton(
              text: 'СДЕЛАТЬ ЗАКАЗ',
              onPressed: () {
                //TODO: Закомментировать!
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

                  playSound();

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
//!========================================================================
// import 'package:flutter/material.dart';
// import '../constants.dart';
// import '../db/database.dart';
// import '../functions.dart';
// import '../theme_settings.dart';
// import '../user_secure_storage.dart';
// import '../widgets/list_view.dart';
// import '../widgets/reusable_button.dart';

// class ShoppingCartPage extends StatefulWidget {
//   const ShoppingCartPage({super.key});
//   @override
//   State<ShoppingCartPage> createState() => _ShoppingCartPageState();
// }

// class _ShoppingCartPageState extends State<ShoppingCartPage> {
//   int? currentUserId;

//   updateCurrentUserId() async {
//     currentUserId = await UserSecureStorage.getCurrentUserId();
//   }

//   @override
//   void initState() {
//     super.initState();
//     updateCurrentUserId();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'КОРЗИНА',
//           style: TextStyle(
//             color: richColor,
//             fontSize: 24.0,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 10.0,
//           vertical: 10.0,
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               child: NewListView(
//                 context: context,
//                 products: productsInShoppingCart,
//                 listViewIcon: deleteIcon,
//                 message: 'Товар удален',
//                 onPressed: () {
//                   playSound();
//                   setState(() {});
//                 },
//                 action: ActionIconType.remove,
//               ),
//             ),
//             ReusableButton(
//               text: 'СДЕЛАТЬ ЗАКАЗ',
//               onPressed: () {
//                 if (productsInShoppingCart.isNotEmpty) {
//                   showCustomSnackBar(
//                     context,
//                     'Заказ принят',
//                   );
//                   productsInShoppingCart.clear(); //TODO: Закомментировать!

//                   // Очистка таблицы ShoppingCart текущего пользователя.
//                   if (currentUserId != null) {
//                     DBProvider.db.deleteAllProductsFromShoppingCart(
//                         userId: currentUserId!);
//                   }

//                   playSound();

//                   setState(() {});
//                 } else {
//                   showCustomSnackBar(
//                     context,
//                     'Коризна пуста',
//                   );
//                   playSound();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//!========================================================================




// import 'package:flutter/material.dart';
// import 'package:shopping_cart/model/shopping_cart.dart';
// import '../constants.dart';
// import '../db/database.dart';
// import '../functions.dart';
// import '../theme_settings.dart';
// import '../user_secure_storage.dart';
// import '../widgets/list_view.dart';
// import '../widgets/reusable_button.dart';

// class ShoppingCartPage extends StatefulWidget {
//   const ShoppingCartPage({super.key});
//   @override
//   State<ShoppingCartPage> createState() => _ShoppingCartPageState();
// }

// class _ShoppingCartPageState extends State<ShoppingCartPage> {
//   late Future<List<ShoppingCart>> _usersShoppingCartList;

//   @override
//   void initState() {
//     // Todo: Загрузить продукты из таблицы "ShoppingCart_User_$userId".
//     super.initState();
//     updateUsersShoppingCartList();
//   }

//   updateUsersShoppingCartList() async {
//     int? currentUserId = await UserSecureStorage.getCurrentUserId();

//     setState(() {
//       _usersShoppingCartList = DBProvider.db.getProductsInShoppingCart(
//         userId: int.parse(currentUserId.toString()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'КОРЗИНА',
//           style: TextStyle(
//             color: richColor,
//             fontSize: 24.0,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 10.0,
//           vertical: 10.0,
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               //! _usersShoppingCartList
//               child: NewListView(
//                 context: context,
//                 // products: productsInShoppingCart,
//                 products: _usersShoppingCartList,
//                 listViewIcon: deleteIcon,
//                 message: 'Товар удален',
//                 onPressed: () {
//                   playSound();
//                   setState(() {});
//                 },
//                 action: ActionIconType.remove,
//               ),
//             ),
//             ReusableButton(
//               text: 'СДЕЛАТЬ ЗАКАЗ',
//               onPressed: () {
//                 if (productsInShoppingCart.isNotEmpty) {
//                   showCustomSnackBar(
//                     context,
//                     'Заказ принят',
//                   );
//                   productsInShoppingCart.clear();
//                   playSound();

//                   setState(() {});
//                 } else {
//                   showCustomSnackBar(
//                     context,
//                     'Коризна пуста',
//                   );
//                   playSound();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
