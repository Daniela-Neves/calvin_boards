import '../database/database_manager.dart';
import '../models/sign_up.dart';

class SignUpRepository {
  Future<List<SignUp>> listarCadastros() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
          SELECT 
            user.id, 
            user.name,
            user.email, 
            user.password,
            user.phone_number
          FROM user
''');
    return rows
        .map(
          (row) => SignUp(
              id: row['user_id'],
              nome: row['name'],
              celular: row['phone_number'],
              email: row['email'],
              senha: row['password']),
        )
        .toList();
  }

  Future<bool> cadastrar(SignUp signup) async {
    final db = await DatabaseManager().getDatabase();
    try {
      db.insert("user", {
        "user_id": signup.id,
        "name": signup.nome,
        "phone_number": signup.celular,
        "email": signup.email,
        "password": signup.senha
      });
    } catch (e) {
      rethrow;
    }
    return true;
  }

  Future<void> remover(int id) async {
    final db = await DatabaseManager().getDatabase();
    await db.delete('user', where: 'user_id = ?', whereArgs: [id]);
  }

  Future<int> editar(SignUp signup) async {
    final db = await DatabaseManager().getDatabase();
    return db.update(
        'user',
        {
          "user_id": signup.id,
          "name": signup.nome,
          "phone_number": signup.celular,
          "email": signup.email,
          "password": signup.senha
        },
        where: 'user_id = ?',
        whereArgs: [signup.id]);
  }

  Future<SignUp?> login(String email, String senha) async {
    final db = await DatabaseManager().getDatabase();
    List<Map<String, Object?>> cadastros =
        await db.query('user', where: 'email = ?', whereArgs: [email]);
    if (cadastros.isEmpty) {
      return null;
    }

    SignUp cadastro =
        cadastros.map((row) => SignUp.fromMap(row)).toList().first;

    if (cadastro.senha == senha) {
      return cadastro;
    }

    return null;
  }
}
