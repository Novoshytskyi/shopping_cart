import 'package:flutter/material.dart';
import '../constants.dart';
import '../db/database.dart';
import '../functions.dart';
import '../model/user.dart';
import '../theme_settings.dart';

class UsersInfoPage extends StatefulWidget {
  const UsersInfoPage({super.key});
  @override
  State<UsersInfoPage> createState() => _UsersInfoPageState();
}

class _UsersInfoPageState extends State<UsersInfoPage> {
  late Future<List<User>> _usersList;

  @override
  void initState() {
    super.initState();
    updateUsersList();
  }

  updateUsersList() {
    setState(() {
      _usersList = DBProvider.db.getUsers();
    });
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
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('id:'),
                                    Text('name:'),
                                    Text('email:'),
                                    Text('pass: '),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![index].id.toString(),
                                      style: const TextStyle(color: lightColor),
                                    ),
                                    Text(
                                      snapshot.data![index].name,
                                      style: const TextStyle(color: lightColor),
                                    ),
                                    Text(
                                      snapshot.data![index].email,
                                      style: const TextStyle(color: lightColor),
                                    ),
                                    Text(
                                      snapshot.data![index].password,
                                      style: const TextStyle(color: lightColor),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      DBProvider.db.deleteUser(
                                          snapshot.data![index].id!);
                                      updateUsersList();
                                      playSound();
                                    },
                                    icon: deleteIcon,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Text(usersInfoMessage);
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
