import 'package:calvin_boards/models/sign_up.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  SignUp? signUp;

  SignUpProvider();

  String getNome() => signUp!.nome;

  void setNome(String nome) {
    signUp!.nome = nome;
    notifyListeners();
  }

  SignUp? getUsuario() => signUp;

  void setSignUp(SignUp signUp) {
    this.signUp = signUp;
    notifyListeners();
  }
}
