import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  Future<Database> getDatabase() async {
    final path = join(await getDatabasesPath(), 'eletrocar.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, _) async {
    await db.execute(_cadastros);
    await db.execute(_cars);
  }

  String get _cadastros => '''
    CREATE TABLE IF NOT EXISTS user (
      user_id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT NOT NULL,
      password TEXT NOT NULL, 
      phone_number TEXT NOT NULL
    )
  ''';

  String get _cars => '''
    CREATE TABLE IF NOT EXISTS car (
      car_id INTEGER PRIMARY KEY AUTOINCREMENT,
      manufacturer TEXT NOT NULL,
      model TEXT NOT NULL,
      plate TEXT NULL,
      year INTEGER NULL,
      mileage INTEGER NULL
    )
  ''';
}
