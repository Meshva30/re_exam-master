import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/home_model.dart';

class DBHelper {
  static Database? _database;

  Future<Database> initDB() async {
    if (_database != null) return _database!;

    String path = join(await getDatabasesPath(), 'shopping_list.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            quantity INTEGER,
            category TEXT,
            purchased INTEGER
          )
        ''');
      },
    );

    return _database!;
  }

  Future<List<ShoppingItem>> getItems() async {
    final db = await initDB();
    final data = await db.query('items');
    return List.generate(data.length, (i) {
      return ShoppingItem.fromMap(data[i]);
    });
  }

  Future<void> insertItem(ShoppingItem item) async {
    final db = await initDB();
    await db.insert('items', item.toMap());
  }

  Future<void> deleteItem(int id) async {
    final db = await initDB();
    await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateItemPurchased(int id, bool purchased) async {
    final db = await initDB();
    await db.update('items', {'purchased': purchased ? 1 : 0},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateItem(ShoppingItem item) async {
    final db = await initDB();
    await db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> syncLocalDatabase(List<ShoppingItem> cloudItems) async {
    final db = await initDB();
    for (var item in cloudItems) {
      await db.insert(
        'shopping_items',
        item.toMap(),

      );
    }
  }
}
