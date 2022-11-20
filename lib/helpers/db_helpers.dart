import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> getDatabase() async {
    final String dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'all_places_DB.db'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE places_table(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insertData(
      String tableName, Map<String, Object> data) async {
    final db = await DBHelper.getDatabase();

    await db.insert(
      tableName,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getAllPlaces(String tableName) async {
    final db = await DBHelper.getDatabase();
    return db.query(tableName);
  }
}
