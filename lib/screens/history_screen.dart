import 'package:flutter/material.dart';
import 'package:shopping_cart/functions.dart';
import '../constants.dart';
import '../db/database.dart';
import '../model/history.dart';
import '../model/user.dart';
import '../theme_settings.dart';
import '../widgets/history_list_view.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    super.key,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = ModalRoute.of(context)!.settings.arguments as User;
    int id = int.parse(currentUser.id.toString());

    late Future<List<History>> historysList;
    historysList = DBProvider.db.getHistory(userId: id);

    void updateHistoryList() {
      historysList = DBProvider.db.getHistory(userId: id);
    }

    void deleteHistory() {
      DBProvider.db.deleteHistory(userId: id);
      setState(() {
        updateHistoryList();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ИСТОРИЯ ПОКУПОК',
          style: TextStyle(
            color: richColor,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () {
                // onPressed!();
                deleteHistory();
                showCustomSnackBar(
                  context,
                  'История очищена',
                );
              },
              icon: deleteHistoryIcon,
            ),
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
                future: historysList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return HistoryListView(
                      context: context,
                      orders: snapshot.data!,
                    );
                  }
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Text('Данные в истории не найденны.');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
