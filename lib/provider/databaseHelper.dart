import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/restaurant.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  DatabaseHelper.internal();

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    path = join(path, 'quick_order.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  void _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS restaurant (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  nif VARCHAR(9) UNIQUE,
  password VARCHAR(50),
  photo VARCHAR(50),
  city varchar(50),
  direction varchar(100),
  delivery_time int,
  delivery_price int,
  rating DECIMAL(3,1)
 );
    ''');
  }

  Future<void> addRestaurant(Restaurant restaurant) async {
    final db = await database;

    final existingRestaurant = await db.query(
      'restaurant',
      where: 'id = ?',
      whereArgs: [restaurant.id],
    );

    if (existingRestaurant.isEmpty) {
      await db.insert(
        'restaurant',
        {
          'id': restaurant.id,
          'name': restaurant.name,
          'nif': restaurant.nif,
          'password': restaurant.password,
          'photo': restaurant.photo,
          'city': restaurant.city,
          'direction': restaurant.direction,
          'delivery_time': restaurant.deliveryTime,
          'delivery_price': restaurant.deliveryPrice,
          'rating': restaurant.rating,
        },
      );
    }
  }

  Future<List<Restaurant>> getRestaurants() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('restaurant');
    return List.generate(maps.length, (i) {
      return Restaurant(
          id: maps[i]['id'],
          name: maps[i]['name'],
          nif: maps[i]['nif'],
          password: maps[i]['password'],
          photo: maps[i]['photo'],
          city: maps[i]['city'],
          direction: maps[i]['direction'],
          deliveryTime: maps[i]['delivery_time'],
          deliveryPrice: maps[i]['delivery_price'],
          rating: maps[i]['rating'],
          tags: []);
    });
  }
}
