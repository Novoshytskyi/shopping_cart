import 'package:flutter/material.dart';
import '../db/database.dart';
import '../model/user.dart';
import '../theme_settings.dart';
import '../widgets/users_list_view.dart';

class UsersInfoScreen extends StatefulWidget {
  const UsersInfoScreen({super.key});
  @override
  State<UsersInfoScreen> createState() => _UsersInfoScreenState();
}

class _UsersInfoScreenState extends State<UsersInfoScreen> {
  late Future<List<User>> _usersList;

  @override
  void initState() {
    super.initState();
    updateUsersList();
  }

  void updateUsersList() {
    _usersList = DBProvider.db.getUsers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ПОЛЬЗОВАТЕЛИ',
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
                future: _usersList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return UsersCardsListView(
                      snapshot: snapshot,
                      onPressed: updateUsersList,
                    );
                  }
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('Данные пользователей не найденны.'),
                    );
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
