import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  Future<Database> getDatabase() async {
    final path = join(await getDatabasesPath(), 'eletrocar.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, _) async {
    await db.execute(_cadastros);
    await db.execute(_createCarsTable);
  }

  String get _cadastros => '''
    CREATE TABLE IF NOT EXISTS user (
      user_id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      email TEXT NOT NULL,
      password TEXT NOT NULL, 
      phone_number TEXT NOT NULL
    )
  ''';

  String get _createCarsTable => '''
    CREATE TABLE IF NOT EXISTS car (
      car_id INTEGER PRIMARY KEY,
      manufacturer TEXT NOT NULL,
      model TEXT NOT NULL,
      plate TEXT NULL,
      yer INTEGER,
      is_hybrid NUMERIC(1,0) NOT NULL,
      charge_percentage INTEGER NULL,
      fuel_level INTEGER NULL,
      mileage INTEGER NULL
    )
  ''';
}
