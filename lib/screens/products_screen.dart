import 'package:flutter/material.dart';
import '../model/product.dart';
import '../constants.dart';
import '../db/database.dart';
import '../model/user.dart';
import '../theme_settings.dart';
import '../widgets/products_list_view.dart';
import '../widgets/popup_menu_button.dart';
import '../widgets/reusable_button.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List<Product>> _productsList;

  User? currentUser;

  @override
  void initState() {
    super.initState();
    updateProductsList();

    setState(() {});
  }

  void updateProductsList() {
    _productsList = DBProvider.db.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
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
            currentUser: currentUser,
            onPressedLogOut: () {
              setState(() {});
              Navigator.pushNamed(context, '/page1');
            },
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
                    return ProductsAndShoppingCartListView(
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
            ReusableButton(
              text: 'ПОКАЗАТЬ КОРЗИНУ',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/page4',
                  arguments: currentUser,
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
