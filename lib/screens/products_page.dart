import 'package:flutter/material.dart';
import '../functions.dart';
import '../model/product.dart';
import '../constants.dart';
import '../db/database.dart';
import '../model/user.dart';
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

  User? currentUser;

  @override
  void initState() {
    super.initState();
    updateProductsList();

    updateCurrentUser();

    setState(() {});

    debugColorPrint('products_page -> Открыт');
  }

  void updateProductsList() {
    _productsList = DBProvider.db.getProducts();
  }

  Future<void> updateCurrentUser() async {
    currentUser = await UserSecureStorage.getCurrentUserInfo();
    setState(() {});

    debugColorPrint(
        'products_page -> currentUser!.id: ${currentUser == null ? '?' : currentUser!.id}');

    debugColorPrint(
        'products_page -> currentUser!.name: ${currentUser == null ? '?' : currentUser!.name}');
  }

  @override
  Widget build(BuildContext context) {
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
            userName: currentUser?.name,
            onPressedLogOut: () {
              setState(() {
                // userName = '';
              });
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
            ReusableButton(
              text: 'ПОКАЗАТЬ КОРЗИНУ',
              onPressed: () {
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
