import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/sign_up.dart';

class SettingsDetailsPage extends StatelessWidget {
  SettingsDetailsPage({Key? key}) : super(key: key);
  late SignUp signup;

  @override
  Widget build(BuildContext context) {
    signup = Provider.of<SignUp>(context, listen: false);
    /*final signup = ModalRoute.of(context)!.settings.arguments as SignUp;
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Nome:'),
              subtitle: Text(
                signup.nome,
              ),
            ),
            ListTile(
              title: const Text('Celular:'),
              subtitle: Text(signup.celular.toString()),
            ),
            ListTile(
              title: const Text('Data de Nascimento:'),
              subtitle: Text(DateFormat('dd/MM/yyyy').format(signup.data)),
            ),
            ListTile(
              title: const Text('Email:'),
              subtitle: Text(
                signup.email,
              ),
            ),
            ListTile(
              title: const Text('Senha:'),
              subtitle: Text(
                signup.senha,
              ),
            ),
          ],
        ),
      ),
    );*/
    return Scaffold(
        body: Column(children: [
      ListTile(
          title: const Text("Meu perfil"),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pushNamed(context, '/signup',
                arguments: context.read<SignUp>());
          })
    ]));
  }
}
