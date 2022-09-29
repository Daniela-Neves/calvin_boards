import '../database/database_manager.dart';
import '../models/sign_up.dart';

class SignUpRepository {
  Future<List<SignUp>> listarCadastros() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
          SELECT 
            cadastros.id, 
            cadastros.nome,
            cadastros.email, 
            cadastros.data,
            cadastros.senha,
            cadastros.celular
          FROM cadastros
''');
    return rows
        .map(
          (row) => SignUp(
            id: row['id'],
            nome: row['nome'],
            celular: row['celular'],
            data: DateTime.fromMillisecondsSinceEpoch(row['data']),
            email: row['email'],
            senha: row['senha'],
          ),
        )
        .toList();
  }

  Future<void> cadastrar(SignUp signup) async {
    final db = await DatabaseManager().getDatabase();

    db.insert("cadastros", {
      "id": signup.id,
      "nome": signup.nome,
      "celular": signup.celular,
      "data": signup.data.millisecondsSinceEpoch,
      "email": signup.email,
      "senha": signup.senha,
    });
  }

  Future<void> remover(int id) async {
    final db = await DatabaseManager().getDatabase();
    await db.delete('cadastros', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> editar(SignUp signup) async {
    final db = await DatabaseManager().getDatabase();
    return db.update(
        'cadastros',
        {
          "id": signup.id,
          "nome": signup.nome,
          "celular": signup.celular,
          "data": signup.data.millisecondsSinceEpoch,
          "email": signup.email,
          "senha": signup.senha,
        },
        where: 'id = ?',
        whereArgs: [signup.id]);
  }

  Future<bool> login(int id, String senha) async {
    final db = await DatabaseManager().getDatabase();
    List<Map<String, Object?>> cadastros =
        await db.query('cadastros', where: 'id = ?', whereArgs: [id]);
    if (cadastros.isEmpty) {
      return false;
    }

    SignUp cadastro =
        cadastros.map((row) => SignUp.fromMap(row)).toList().first;

    if (cadastro.senha == senha) {
      return true;
    }

    return false;
  }
}
