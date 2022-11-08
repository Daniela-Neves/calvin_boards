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

  String get _createCarsTable => '''
    CREATE TABLE IF NOT EXISTS carros (
      id INTEGER PRIMARY KEY,
      marca TEXT NOT NULL,
      modelo TEXT NOT NULL,
      placa TEXT NULL,
      ano INTEGER,
      is_hibrido NUMERIC(1,0) NOT NULL,
      carga_eletrica INTEGER NULL,
      nivel_combustivel INTEGER NULL,
      quilometragem INTEGER NULL
    )
  ''';

  String get _createUserCarsTable => '''
    CREATE TABLE IF NOT EXISTS carros_usuario (
      id_carro INTEGER NOT NULL,
      id_
    )
''';
}
