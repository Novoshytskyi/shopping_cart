import 'package:flutter/material.dart';
import 'package:shopping_cart/functions.dart';
import '../theme_settings.dart';
import '../widgets/history_card.dart';

import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back,
        //   ),
        //   onPressed: () {
        //     Navigator.pushNamed(context, '/page1');
        //   },
        // ),
        title: const Text(
          'ИСТОРИЯ ПОКУПОК',
          style: TextStyle(
            color: richColor,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        // child: Center(
        //   child: Text(
        //     'Здесь будет\n\nИСТОРИЯ ПОКУПОК\n\nтекущего пользователя',
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //       color: richColor,
        //       fontSize: 24.0,
        //     ),
        //   ),
        // ),
        child: Column(
          children: [
            HistoryCard(
              id: 1,
              time: '12:45',
              date: '17.07.25.',
              name: 'MacBook Air M4 midnight',
              price: 1000.0,
              image: 'images/air-m4-midnight.jpg',
              orderPrice: 2000.0,
            ),
            SizedBox(
              height: 100.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        // backgroundColor: richColor,
        onPressed: () {
          // Add your onPressed code here!
          DateTime now = DateTime.now();
          String time = DateFormat('HH:mm').format(now);
          String date = DateFormat('dd.MM.yy').format(now);

          debugColorPrint(time);
          debugColorPrint(date);
        },
        child: const Icon(Icons.watch_later_outlined),
      ),
    );
  }
}
