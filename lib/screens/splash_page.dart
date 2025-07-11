import 'package:flutter/material.dart';
import '../model/user.dart';
import '../user_secure_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initFromSecureStorage();
  }

  Future initFromSecureStorage() async {
    User? currentUser = await UserSecureStorage.getCurrentUserInfo();
    routeSelection(currentUser);
  }

  void routeSelection(User? currentUser) {
    if (currentUser == null) {
      Navigator.pushNamed(context, '/page1');
    } else {
      Navigator.pushNamed(context, '/page3');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: const Image(
                  // fit: BoxFit.fitWidth,
                  image: AssetImage('images/logo_big.png'),
                  width: 140.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
