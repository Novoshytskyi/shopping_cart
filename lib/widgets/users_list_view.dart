import 'package:flutter/material.dart';

import '../constants.dart';
import '../db/database.dart';
import '../functions.dart';
import '../model/user.dart';
import '../theme_settings.dart';

class UsersCardsListView extends StatelessWidget {
  const UsersCardsListView({
    super.key,
    required this.snapshot,
    required this.onPressed,
  });

  final AsyncSnapshot<List<User>> snapshot;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
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
                      DBProvider.db.deleteUser(snapshot.data![index].id!);

                      onPressed();

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
}
