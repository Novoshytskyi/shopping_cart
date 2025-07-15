import 'package:flutter/material.dart';

import '../theme_settings.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.date,
  });

  final int id;
  final String name;
  final double price;
  final String image;
  final String date;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      date,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            // color: lightColor,
                            fontSize: 16.0,
                          ),
                    ),
                  ],
                ),
                const Divider(
                  color: richColor,
                  thickness: 1.5,
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image(
                            image: AssetImage(image),
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
                                  name,
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
                                  '$price \$',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
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
                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image(
                            image: AssetImage(image),
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
                                  name,
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
                                  '$price \$',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
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
                            // fontSize: 16.0,
                          ),
                    ),
                    Text(
                      '$price \$', //todo: price изменить на sum
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: lightColor,
                            // fontSize: 16.0,
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

class HistoryCardSimple extends StatelessWidget {
  const HistoryCardSimple({
    super.key,
    required this.id,
    required this.name,
    required this.orderPrice,
    required this.time,
    required this.date,
  });

  final int id;
  final String name;
  final double orderPrice;
  final String time;
  final String date;

  @override
  Widget build(BuildContext context) {
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
                      date,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            // color: lightColor,
                            fontSize: 16.0,
                          ),
                    ),
                    Text(
                      time,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            // color: lightColor,
                            fontSize: 16.0,
                          ),
                    ),
                  ],
                ),
                const Divider(
                  color: richColor,
                  thickness: 1.5,
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                            // fontSize: 16.0,
                          ),
                    ),
                    Text(
                      '$orderPrice \$',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: lightColor,
                            // fontSize: 16.0,
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

class HistoryCardSimple2 extends StatelessWidget {
  const HistoryCardSimple2({
    super.key,
    required this.id,
    required this.nameList,
    required this.priceList,
    required this.orderPrice,
    required this.time,
    required this.date,
  });

  final int id;
  final List<String> nameList;
  final List<double> priceList;
  final double orderPrice;
  final String time;
  final String date;

  @override
  Widget build(BuildContext context) {
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
                      date,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            // color: lightColor,
                            fontSize: 16.0,
                          ),
                    ),
                    Text(
                      time,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            // color: lightColor,
                            fontSize: 16.0,
                          ),
                    ),
                  ],
                ),
                const Divider(
                  color: richColor,
                  thickness: 1.5,
                ),
                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  nameList[0].toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: richColor),
                                ),
                                Text(
                                  '${priceList[0]} \$',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  nameList[1].toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: richColor),
                                ),
                                Text(
                                  '${priceList[1]} \$',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                            // fontSize: 16.0,
                          ),
                    ),
                    Text(
                      '$orderPrice \$',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: lightColor,
                            // fontSize: 16.0,
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
