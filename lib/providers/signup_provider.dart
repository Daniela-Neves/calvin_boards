import 'package:calvin_boards/models/sign_up.dart';
import 'package:flutter/material.dart';
import '../database/database_manager.dart';

class SignUpProvider extends ChangeNotifier {
  SignUp? signUp;

  bool _disposed = false;
  final db = DatabaseManager().getDatabase();

  SignUpProvider();

  String getNome() => signUp!.nome;

  void setNome(String nome) {
    signUp!.nome = nome;
    notifyListeners();
  }

  String getEmail() => signUp!.email;

  void setEmail(String email) {
    signUp!.email = email;
    notifyListeners();
  }

  SignUp? getUsuario() => signUp;

  void setSignUp(SignUp signUp) {
    this.signUp = signUp;
    notifyListeners();
  }

  Future<void> remover() async {
    final db = await DatabaseManager().getDatabase();
    await db.delete('cadastros', where: "id = ?", whereArgs: [signUp!.id]);
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = false;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_disposed) {
      super.notifyListeners();
    }
  }
}
