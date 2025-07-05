import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'model/user.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyUserInfo = 'currentUserInfo';

  static Future setCurrentUserInfo(User activeUser) async {
    final value = json.encode(activeUser.toMap());
    await _storage.write(key: _keyUserInfo, value: value);
  }

  static Future<User?> getCurrentUserInfo() async {
    final value = await _storage.read(key: _keyUserInfo);

    return value == null ? null : User.fromMap(json.decode(value));
  }

  static Future logOut() async => await _storage.deleteAll();
}
