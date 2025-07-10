import 'package:flutter/material.dart';
import '../model/product.dart';
import '../constants.dart';
import '../db/database.dart';
import '../functions.dart';
import '../theme_settings.dart';
import '../user_secure_storage.dart';
import '../widgets/list_view.dart';
import '../widgets/popup_menu_button.dart';
import '../widgets/reusable_button.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late Future<List<Product>> _productsList;

  String? userName;

  @override
  void initState() {
    super.initState();
    updateProductsList();
    userAuthCheckFromSecureStorage();
    setState(() {});
  }

  updateProductsList() {
    setState(() {
      _productsList = DBProvider.db.getProducts();
    });
  }

  Future userAuthCheckFromSecureStorage() async {
    var currentUser = await UserSecureStorage.getCurrentUserInfo();
    if (currentUser == null) {
      // Navigator.pushNamed(context, '/page1');
    } else {
      userName = currentUser.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back,
        //   ),
        //   onPressed: () {
        //     Navigator.pushNamed(context, '/page1');
        //   },
        // ),
        title: const Text(
          'ТОВАРЫ',
          style: TextStyle(
            color: richColor,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButtonNew(
            onPressedLogOut: () {
              setState(() {
                userName = '';
              });
              Navigator.pushNamed(context, '/page1');
            },
            userName: userName,
          ),
        ],
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
                future: _productsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return NewListView(
                      context: context,
                      products: snapshot.data!,
                      listViewIcon: shoppingCartIcon,
                      message: 'Добавлен в корзину',
                      onPressed: () {
                        playSound();
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
            ReusableButton(
              text: 'ПОКАЗАТЬ КОРЗИНУ',
              onPressed: () {
                // playSound();
                Navigator.pushNamed(
                  context,
                  '/page4',
                  arguments: null,
                );
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*

import 'package:flutter/material.dart';
import '../model/product.dart';
import '../constants.dart';
import '../db/database.dart';
import '../functions.dart';
import '../theme_settings.dart';
import '../user_secure_storage.dart';
import '../widgets/list_view.dart';
import '../widgets/popup_menu_button.dart';
import '../widgets/reusable_button.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late Future<List<Product>> _productsList;

  String? userName;

  @override
  void initState() async {
    super.initState();
    await userAuthCheckFromSecureStorage();
    updateProductsList();
  }

  updateProductsList() {
    setState(() {
      _productsList = DBProvider.db.getProducts();
    });
  }

  Future userAuthCheckFromSecureStorage() async {
    var currentUser = await UserSecureStorage.getCurrentUserInfo();
    if (currentUser == null) {
      // Navigator.pushNamed(context, '/page1');
    } else {
      userName = currentUser.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back,
        //   ),
        //   onPressed: () {
        //     Navigator.pushNamed(context, '/page1');
        //   },
        // ),
        title: const Text(
          'ТОВАРЫ',
          style: TextStyle(
            color: richColor,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButtonNew(
            onPressedLogOut: () {
              // clearAuthFields();
              // userIsActive = false;
              //???
              setState(() {
                userName = '';
              });
              Navigator.pushNamed(context, '/page1');
            },
            userName: userName,
          ),
        ],
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
                future: _productsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return NewListView(
                      context: context,
                      products: snapshot.data!,
                      listViewIcon: shoppingCartIcon,
                      message: 'Добавлен в корзину',
                      onPressed: () {
                        playSound();
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
            ReusableButton(
              text: 'ПОКАЗАТЬ КОРЗИНУ',
              onPressed: () {
                // playSound();
                Navigator.pushNamed(
                  context,
                  '/page4',
                  arguments: null,
                );
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}


*/
