import 'dart:io';
// import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopping_cart/model/product.dart';
// import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import '../model/user.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database? _database;

  String usersTable = 'Users';
  String columnId = 'id';
  String columnName = 'name';
  String columnEmail = 'email';
  String columnPassword = 'password';

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

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Products (
      id INTEGER  PRIMARY KEY AUTOINCREMENT,
      name TEXT    NOT NULL,
      price TEXT   NOT NULL,
      image TEXT  NOT NULL
      );
    ''');

    await db.execute('''
      INSERT INTO Products (name, price, image)
      VALUES
      ('Apple MacBook Air M4', '1000', 'images/air-m4-starlight.jpg'),
      ('Apple MacBook Air M4', '1000', 'images/air-m4-silver.jpg'),
      ('Apple MacBook Air M4', '1000', 'images/air-m4-sky-blue.jpg'),
      ('Apple MacBook Air M4', '1000', 'images/air-m4-midnight.jpg'),
      ('Apple MacBook Air M1',  '800', 'images/air-m1-space-gray.jpg'),
      ('Apple MacBook Air M1', '800',  'images/air-m1-gold.jpg'),
      ('Apple MacBook Pro M4', '1600', 'images/pro-m4-silver.jpg'),
      ('Apple MacBook Pro M4', '1600', 'images/pro-m4-space-black.jpg'),
      ('Apple MacBook Pro M3', '1300', 'images/pro-m2-pro-silver.jpg'),
      ('Apple MacBook Pro M3', '1300', 'images/pro-m2-space-gray.jpg');
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS Users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      email TEXT,
      password TEXT
      );
    ''');
  }

  //-----------------------------------------------------

  // Read Users
  Future<List<User>> getUsers() async {
    Database? db = await database;
    final List<Map<String, dynamic>> usersMapList = await db!.query(usersTable);
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
    user.id = (await db?.insert(usersTable, user.toMap()))!;
    return user;
  }

  //Update User
  Future<int?> updateUser(User user) async {
    Database? db = await database;
    return await db?.update(
      usersTable,
      user.toMap(),
      where: '$columnId = ?',
      whereArgs: [user.id],
    );
  }

  // Delete User
  Future<int?> deleteUser(int id) async {
    Database? db = await database;
    return await db?.delete(
      usersTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  //? create Table Products
  // void _createTableProducts(Database db, int version) async {
  //   await db.execute('''
  //     CREATE TABLE IF NOT EXISTS Products (
  //     id INTEGER  PRIMARY KEY,
  //     name TEXT    NOT NULL,
  //     price TEXT   NOT NULL,
  //     image TEXT  NOT NULL
  //       );

  //     INSERT INTO Products (name, price, image)
  //     VALUES
  //     ('Apple MacBook Air M4', '1000', 'images/air-m4-starlight.jpg'),
  //     ('Apple MacBook Air M4', '1000', 'images/air-m4-silver.jpg'),
  //     ('Apple MacBook Air M4', '1000', 'images/air-m4-sky-blue.jpg'),
  //     ('Apple MacBook Air M4', '1000', 'images/air-m4-midnight.jpg'),
  //     ('Apple MacBook Air M1',  '800', 'images/air-m1-space-gray.jpg'),
  //     ('Apple MacBook Air M1', '800',  'images/air-m1-gold.jpg'),
  //     ('Apple MacBook Pro M4', '1600', 'images/pro-m4-silver.jpg'),
  //     ('Apple MacBook Pro M4', '1600', 'images/pro-m4-space-black.jpg'),
  //     ('Apple MacBook Pro M3', '1300', 'images/pro-m2-pro-silver.jpg'),
  //     ('Apple MacBook Pro M3', '1300', 'images/pro-m2-space-gray.jpg');
  //   ''');
  // }

  // Read Table Products
  Future<List<Product>> getProducts() async {
    Database? db = await database;
    final List<Map<String, dynamic>> productsMapList =
        await db!.query('Products');
    final List<Product> productsList = [];
    for (var productMap in productsMapList) {
      productsList.add(
        Product.fromMap(productMap),
      );
    }
    return productsList;
  }
}
