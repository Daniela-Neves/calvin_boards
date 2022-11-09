import 'package:flutter/material.dart';

class SignUp extends ChangeNotifier {
  int? id;
  String nome;
  String celular;
  String email;
  String senha;

  SignUp(
      {this.id,
      required this.nome,
      required this.celular,
      required this.email,
      required this.senha});

  factory SignUp.fromMap(Map<String, dynamic> map) {
    return SignUp(
        id: map['user_id'],
        nome: map['name'],
        celular: map['phone_number'],
        email: map['email'],
        senha: map['password']);
  }
}
