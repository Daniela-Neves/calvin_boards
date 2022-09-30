import 'package:calvin_boards/models/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpProvider extends ChangeNotifier {
  SignUp? signUp;

  SignUpProvider({required SignUp this.signUp}) {
    notifyListeners();
  }

  String getNome() => signUp!.nome;

  void setNome(String nome) {
    signUp!.nome = nome;
    notifyListeners();
  }

  SignUp? getUsuario() => signUp;
}
