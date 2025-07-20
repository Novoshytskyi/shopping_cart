import 'package:flutter/material.dart';
import 'package:shopping_cart/model/history.dart';

import 'history_card.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({
    super.key,
    required BuildContext context,
    required this.orders,
  });

  final List<History> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) => HistoryCard(
        id: orders[index].id,
        time: orders[index].time,
        date: orders[index].date,
        orderPrice: orders[index].orderPrice,
        productsInfo: orders[index].productsInfo,
      ),
    );
  }
}
