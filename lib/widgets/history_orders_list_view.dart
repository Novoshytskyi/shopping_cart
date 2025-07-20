// class HistoryOrdersListView {}

import 'package:flutter/material.dart';

import '../model/product_in_shopping_cart.dart';
import '../theme_settings.dart';

class HistoryOrdersListView extends StatelessWidget {
  const HistoryOrdersListView({
    super.key,
    required this.productsInOrderList,
  });

  final List<ProductInShoppingCart> productsInOrderList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productsInOrderList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image(
                  image: AssetImage(productsInOrderList[index].image),
                  height: 50.0,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        productsInOrderList[index].name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Row(
                    children: [
                      Text(
                        '${productsInOrderList[index].price} \$',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: lightColor,
                              fontSize: 18.0,
                            ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 10.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
