import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  //opening or creating the database
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, "spaces.db"),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_spaces(id TEXT PRIMARY KEY, title TEXT, image TEXT )');
    }, version: 1);
  }

  //inserting data to the table user space
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  //get data from the table user space
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
