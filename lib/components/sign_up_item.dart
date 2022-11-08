import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/sign_up.dart';

class SignUpListItem extends StatelessWidget {
  final SignUp signUp;

  const SignUpListItem({Key? key, required this.signUp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Nome:'),
          subtitle: Text(
            signUp.nome,
          ),
        ),
        ListTile(
          title: const Text('Nome do Carro:'),
          subtitle: Text(
            signUp.nomeCarro,
          ),
        ),
        ListTile(
          title: const Text('Celular:'),
          subtitle: Text(signUp.celular),
        ),
        ListTile(
          title: const Text('Data de Nascimento:'),
          subtitle: Text(DateFormat('dd/MM/yyyy').format(signUp.data)),
        ),
        ListTile(
          title: const Text('Email:'),
          subtitle: Text(
            signUp.email,
          ),
        ),
      ],
    );
  }
}
