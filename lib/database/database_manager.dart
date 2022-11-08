import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  Future<Database> getDatabase() async {
    final path = join(await getDatabasesPath(), 'eletrocar.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, _) async {
    await db.execute(_cadastros);
  }

  String get _cadastros => '''
    CREATE TABLE IF NOT EXISTS cadastros (
      id INTEGER PRIMARY KEY,
      nome TEXT NOT NULL,
      email TEXT UNIQUE NOT NULL,
      senha TEXT NOT NULL, 
      data INTEGER NOT NULL,
      celular TEXT UNIQUE NOT NULL,
      nomeCarro TEXT NOT NULL
    )
  ''';
}
