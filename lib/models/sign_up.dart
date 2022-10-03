import 'package:flutter/material.dart';

class SignUp extends ChangeNotifier {
  int? id;
  String nome;
  String celular;
  DateTime data;
  String email;
  String senha;

  SignUp({
    this.id,
    required this.nome,
    required this.celular,
    required this.email,
    required this.data,
    required this.senha,
  });

  factory SignUp.fromMap(Map<String, dynamic> map) {
    return SignUp(
        id: map['id'],
        nome: map['nome'],
        celular: map['celular'],
        email: map['email'],
        data: DateTime.fromMillisecondsSinceEpoch(map['data']),
        senha: map['senha']);
  }
}
