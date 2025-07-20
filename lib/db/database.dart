import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shopping_cart/model/history.dart';
import 'package:shopping_cart/model/product.dart';
import 'package:sqflite/sqflite.dart';
import '../functions.dart';
import '../model/product_in_shopping_cart.dart';
import '../model/shopping_cart.dart';
import '../model/user.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDB();
    return _database;
  }

  Future<Database?> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();

    String path = '${dir.path}ShoppingDB.db';

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDb,
    );
  }

  String jsonEncodedProductsInShoppingCartInfo = '';

  void _createDb(Database db, int version) async {
    // Создание таблицы Продуктов
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Products (
          id INTEGER  PRIMARY KEY AUTOINCREMENT,
          name  TEXT  NOT NULL,
          price REAL  NOT NULL,
          image TEXT  NOT NULL
          );
    ''');

    // Наполнение таблицы Продуктов
    await db.execute('''
      INSERT INTO Products (name, price, image)
      VALUES
          ('MacBook Air M4 starlight', 1000, 'images/air-m4-starlight.jpg'),
          ('MacBook Air M4 silver', 1000, 'images/air-m4-silver.jpg'),
          ('MacBook Air M4 blue', 1000, 'images/air-m4-sky-blue.jpg'),
          ('MacBook Air M4 midnight', 1000, 'images/air-m4-midnight.jpg'),
          ('MacBook Air M1 gray',  800, 'images/air-m1-space-gray.jpg'),
          ('MacBook Air M1 gold', 800,  'images/air-m1-gold.jpg'),
          ('MacBook Pro M4 silver', 1600, 'images/pro-m4-silver.jpg'),
          ('MacBook Pro M4 black', 1600, 'images/pro-m4-space-black.jpg'),
          ('MacBook Pro M3 silver', 1300, 'images/pro-m2-pro-silver.jpg'),
          ('MacBook Pro M3 gray', 1300, 'images/pro-m2-space-gray.jpg');
    ''');

    // Создание таблицы Пользователей
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      email TEXT,
      password TEXT
      );
    ''');
  }

  // Read Users
  Future<List<User>> getUsers() async {
    Database? db = await database;
    final List<Map<String, dynamic>> usersMapList = await db!.query("Users");
    final List<User> usersList = [];
    for (var userMap in usersMapList) {
      usersList.add(
        User.fromMap(userMap),
      );
    }
    return usersList;
  }

  // Insert User
  Future<User> insertUser(User user) async {
    Database? db = await database;
    user.id = (await db?.insert("Users", user.toMap()))!;
    return user;
  }

  // Update User
  Future<int?> updateUser(User user) async {
    Database? db = await database;
    return await db?.update(
      'Users',
      user.toMap(),
      where: '"id" = ?',
      whereArgs: [user.id],
    );
  }

  // Delete User
  // Удадить таблицы этого пользователя ShoppingCart и History
  Future<int?> deleteUser(int id) async {
    Database? db = await database;
    return await db?.delete(
      'Users',
      where: '"id" = ?',
      whereArgs: [id],
    );
  }

  // Read Table Products
  Future<List<Product>> getProducts() async {
    Database? db = await database;
    final List<Map<String, dynamic>> productsMapList =
        await db!.query("Products");
    final List<Product> productsList = [];
    for (var productMap in productsMapList) {
      productsList.add(
        Product.fromMap(productMap),
      );
    }
    return productsList;
  }

  // Получение id только зарегестрированного пользователя
  Future<int> getNewUserId() async {
    Database? db = await database;
    var res = await db!.rawQuery("SELECT MAX(id) FROM Users;");
    return int.parse(res[0]['MAX(id)'].toString());
  }

  // Получение только зарегестрированного пользователя
  Future<User> getNewUser() async {
    Database? db = await database;
    final List<Map<String, dynamic>> res =
        await db!.rawQuery("SELECT * FROM Users ORDER BY id DESC LIMIT 1;");

    return User.fromMap(res[0]);
  }

  // Получение пароля по введенному email.
  Future<String> getPassByEmail(String email) async {
    Database? db = await database;
    String pass = '';
    final res =
        await db!.rawQuery("SELECT password FROM Users WHERE email='$email';");
    try {
      pass = res[0]['password'].toString();
    } catch (e) {
      pass = '';
    }
    return pass;
  }

  //TODO: Объединить запрос пароляи и почты!

  // Получение пользователя по введенному email.
  Future<User> getUserByEmail(String email) async {
    Database? db = await database;

    final res =
        await db!.rawQuery("SELECT * FROM Users WHERE email = '$email' ; ");

    return User.fromMap(res[0]);
  }

  //! Создание таблицы ShoppingCart (для нового пользователя)
  Future<void> createTableShoppingCart(int userId) async {
    Database? db = await database;
    await db?.execute('''
      CREATE TABLE IF NOT EXISTS ShoppingCart_User_$userId (
      id INTEGER  PRIMARY KEY AUTOINCREMENT,
      productId INTEGER  NOT NULL
      );
    ''');
  }

  //! Добавление товара в таблицу ShoppingCart пользователя
  Future<ShoppingCart> insertProductToShoppingCart({
    required ShoppingCart shoppingCart,
    required int userId,
  }) async {
    Database? db = await database;
    shoppingCart.id = (await db?.insert(
      "ShoppingCart_User_$userId",
      shoppingCart.toMap(),
    ))!;

    return shoppingCart;
  }

  //! Удаление товара из таблицы ShoppingCart пользователя
  Future<int?> deleteProductFromShoppingCart({
    required int productId,
    required int userId,
  }) async {
    Database? db = await database;

    return await db?.delete(
      "ShoppingCart_User_$userId",
      where: '"id" = ?',
      whereArgs: [productId],
    );
  }

  //! Удаление всех товаров из из таблицы ShoppingCart пользователя
  Future<void> deleteAllProductsFromShoppingCart({
    required int userId,
  }) async {
    Database? db = await database;
    await db?.execute("DELETE  FROM ShoppingCart_User_$userId ;");
  }

  //! Получение карт товаров из таблицы ShoppingCart пользователя
  Future<List<ProductInShoppingCart>> getProductsInShoppingCart({
    required int userId,
  }) async {
    Database? db = await database;
    final List<Map<String, dynamic>> userShoppingCartMapList =
        await db!.rawQuery('''
      SELECT 
      ShoppingCart_User_$userId.id AS id, 
      Products.id AS productId, 
      Products.name AS name, 
      Products.price AS price, 
      Products.image AS image
      FROM Products 
      INNER JOIN ShoppingCart_User_$userId 
      where Products.id = ShoppingCart_User_$userId.productId
      ORDER BY  Products.id;
    ''');
    final List<ProductInShoppingCart> usersShoppingCartList = [];
    for (var item in userShoppingCartMapList) {
      usersShoppingCartList.add(
        ProductInShoppingCart.fromMap(item),
      );
    }

    jsonEncodedProductsInShoppingCartInfo =
        json.encode(userShoppingCartMapList); //TODO ПРОКОММЕНТИРОВАТЬ!

    return usersShoppingCartList;
  }

  //! Создание таблицы History (для нового пользователя)
  Future<void> createTableHistory({
    required int userId,
  }) async {
    Database? db = await database;
    await db?.execute('''
      CREATE TABLE IF NOT EXISTS History_User_$userId (
      id INTEGER  PRIMARY KEY AUTOINCREMENT,
      time TEXT  NOT NULL,
      date TEXT  NOT NULL,
      orderPrice REAL NOT NULL,
      productsInfo TEXT NOT NULL   
      );
    ''');
  }

  //! Добавление в таблицу History данных из таблицы ShoppingCart пользователя

  Future<void> addShoppingCartToHistory({
    required int userId,
    required String cartsProductList,
  }) async {
    Database? db = await database;

    await db?.execute('''
      INSERT INTO History_User_$userId (time, date, orderPrice, productsInfo)
      VALUES  (
      strftime('%H:%M', 'now', 'localtime'), 
      strftime('%d.%m.%Y', 'now', 'localtime'), 
      (SELECT SUM(Products.price) 
      FROM Products 
      INNER JOIN ShoppingCart_User_$userId 
      where Products.id = ShoppingCart_User_$userId.productId),
      ('$jsonEncodedProductsInShoppingCartInfo')
      );
    ''');
  }

  //! Получение истории покупок товаров из таблицы History пользователя
  Future<List<History>> getHistory({
    required int userId,
  }) async {
    Database? db = await database;

    final List<Map<String, dynamic>> historyMapList =
        await db!.query("History_User_$userId");
    final List<History> historyList = [];
    for (var historyMap in historyMapList) {
      historyList.add(
        History.fromMap(historyMap),
      );
    }

    return historyList;
  }

  //! Удаление истории покупок товаров из таблицы History пользователя
  Future<void> deleteHistory({
    required int userId,
  }) async {
    Database? db = await database;
    await db?.execute("DELETE  FROM History_User_$userId ;");
  }
}
