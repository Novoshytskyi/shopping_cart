import 'package:flutter/material.dart';
import '../model/product.dart';
import '../constants.dart';
import '../db/database.dart';
import '../functions.dart';
import '../theme_settings.dart';
import '../widgets/list_view.dart';
import '../widgets/reusable_button.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late Future<List<Product>> _productsList;

  @override
  void initState() {
    super.initState();
    updateProductsList();
  }

  updateProductsList() {
    setState(() {
      _productsList = DBProvider.db.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ТОВАРЫ',
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
                future: _productsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // return generateList(snapshot.data!);
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
