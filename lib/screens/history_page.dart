import 'package:flutter/material.dart';
import '../functions.dart';
import '../theme_settings.dart';
import '../widgets/history_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    debugColorPrint('history_page -> Открыт');
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
            SizedBox(
              height: 100.0,
            ),
            //?=================================================
            HistoryCard(
              id: 1,
              name: 'MacBook Air M4 midnight',
              price: 1000.0,
              image: 'images/air-m4-midnight.jpg',
              date: '14.07.25.',
            ),
            //?=================================================
            SizedBox(
              height: 100.0,
            ),
            //?=================================================
          ],
        ),
      ),
    );
  }
}
