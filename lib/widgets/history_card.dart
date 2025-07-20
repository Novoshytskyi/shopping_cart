import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shopping_cart/model/product_in_shopping_cart.dart';
import '../theme_settings.dart';
import 'history_orders_list_view.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.id,
    required this.time,
    required this.date,
    required this.orderPrice,
    required this.productsInfo,
  });

  final int id;
  final String time;
  final String date;
  final double orderPrice;
  final String productsInfo; // json

  @override
  Widget build(BuildContext context) {
    final jsonDecodedProductsInfo = json.decode(productsInfo);

    List<ProductInShoppingCart> productsInOrderList = [];

    for (var product in jsonDecodedProductsInfo) {
      productsInOrderList.add(ProductInShoppingCart.fromMap(product));
    }

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      time,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16.0,
                          ),
                    ),
                    Text(
                      date,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16.0,
                          ),
                    ),
                  ],
                ),
                const Divider(
                  color: richColor,
                  thickness: 1.5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: HistoryOrdersListView(
                        productsInOrderList: productsInOrderList,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: richColor,
                  thickness: 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Сумма заказа:',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: lightColor,
                          ),
                    ),
                    Text(
                      '$orderPrice \$',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: lightColor,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
