import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  Future<Database> getDatabase() async {
    final path = join(await getDatabasesPath(), 'calvinboards.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(_cadastros);
  }

  String get _cadastros => '''
    CREATE TABLE IF NOT EXISTS cadastros (
      id INTEGER PRIMARY KEY,
      nome TEXT NOT NULL,
      email TEXT UNIQUE NOT NULL,
      senha TEXT NOT NULL, 
      data INTEGER NOT NULL,
      celular TEXT UNIQUE NOT NULL
    );
  ''';

  String get _graficos => '''
  CREATE TABLE IF NOT EXISTS graficos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    tipo TEXT NOT NULL
  );
''';

  String get _dados => '''
  CREATE TABLE IF NOT EXISTS dados (
    data INTEGER NOT NULL,
    produto TEXT NOT NULL,
    producao INT NOT NULL,
    PRIMARY KEY (data, produto, producao)
  )

''';
}
