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
          case 'item3':
            {
              Navigator.pushNamed(context, '/page3');
            }
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
        PopupMenuItem(
          height: userName != '' ? kMinInteractiveDimension : 0.0,
          child: userName != ''
              ? Row(
                  children: [
                    const Icon(Icons.person_outlined),
                    const SizedBox(width: 12.0),
                    Text(userName.toString().toUpperCase()),
                  ],
                )
              : const SizedBox(),
        ),

        PopupMenuItem(
          value: 'item1',
          height: userName != '' ? kMinInteractiveDimension : 0.0,
          child: userName != ''
              ? const Row(
                  children: [
                    Icon(Icons.shopping_cart_outlined),
                    SizedBox(width: 12.0),
                    Text('Корзина'),
                  ],
                )
              : const SizedBox(),
        ),
        PopupMenuItem(
          value: 'item2',
          height: userName != '' ? kMinInteractiveDimension : 0.0,
          child: userName != ''
              ? const Row(
                  children: [
                    Icon(Icons.shopping_cart_checkout_outlined),
                    SizedBox(width: 12.0),
                    Text('Покупки'),
                  ],
                )
              : const SizedBox(),
        ),
        PopupMenuItem(
          enabled: false,
          height: userName != '' ? 2.0 : 0.0,
          value: null,
          child: userName != ''
              ? const Divider(
                  color: richColor,
                  thickness: 2.0,
                )
              : const SizedBox(),
        ),
        const PopupMenuItem(
          value: 'item3',
          child: Row(
            children: [
              Icon(Icons.shopping_bag_outlined),
              SizedBox(width: 12.0),
              Text('Товары'),
            ],
          ),
        ),

        //TODO: Скрыть в релиз. режиме.
        const PopupMenuItem(
          value: 'item4',
          height: kReleaseMode ? 0.0 : kMinInteractiveDimension, //? +
          // height: kDebugMode ? 0.0 : kMinInteractiveDimension,  //? -
          child: kReleaseMode //? +
              // child: kDebugMode //? -
              ? null
              : Row(
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
