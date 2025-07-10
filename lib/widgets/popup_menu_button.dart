import 'package:flutter/material.dart';
import '../theme_settings.dart';
import 'package:flutter/foundation.dart';
import '../user_secure_storage.dart';

class PopupMenuButtonNew extends StatelessWidget {
  const PopupMenuButtonNew({
    super.key,
    required this.userName,
    required this.onPressedLogOut,
  });

  final Function onPressedLogOut;
  final String? userName;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        switch (value) {
          case 'item1':
            {
              Navigator.pushNamed(context, '/page4');
            }
          case 'item2':
            {
              Navigator.pushNamed(context, '/page6');
            }
          // case 'item3':
          //   {
          //     Navigator.pushNamed(context, '/page3');
          //   }
          case 'item4':
            {
              Navigator.pushNamed(context, '/page5');
            }
          case 'item5':
            {
              UserSecureStorage.logOut();
              onPressedLogOut();
            }
        }
      },
      itemBuilder: (context) => [
        if (userName != '') ...[
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(Icons.person_outlined),
                const SizedBox(width: 12.0),
                Text(userName.toString().toUpperCase()),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'item1',
            child: Row(
              children: [
                Icon(Icons.shopping_cart_outlined),
                SizedBox(width: 12.0),
                Text('Корзина'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'item2',
            child: Row(
              children: [
                Icon(Icons.shopping_cart_checkout_outlined),
                SizedBox(width: 12.0),
                Text('Покупки'),
              ],
            ),
          ),
          const PopupMenuItem(
            enabled: false,
            height: 2.0,
            value: null,
            child: Divider(
              color: richColor,
              thickness: 2.0,
            ),
          ),
        ],
        // const PopupMenuItem(
        //   value: 'item3',
        //   child: Row(
        //     children: [
        //       Icon(Icons.shopping_bag_outlined),
        //       SizedBox(width: 12.0),
        //       Text('Товары'),
        //     ],
        //   ),
        // ),
        if (!kReleaseMode) ...[
          const PopupMenuItem(
            value: 'item4',
            child: Row(
              children: [
                Icon(Icons.people_alt_outlined),
                SizedBox(width: 12.0),
                Text('Пользователи'),
              ],
            ),
          ),
          const PopupMenuItem(
            enabled: false,
            height: 2.0,
            value: null,
            child: Divider(
              color: richColor,
              thickness: 2.0,
            ),
          ),
        ],
        const PopupMenuItem(
          value: 'item5',
          child: Row(
            children: [
              Icon(Icons.logout_outlined),
              SizedBox(width: 12.0),
              Text('Выход'),
            ],
          ),
        ),
      ],
    );
  }
}
