import 'package:calvin_boards/models/sign_up.dart';
import 'package:calvin_boards/pages/login_page.dart';
import 'package:calvin_boards/pages/my_account_page.dart';
import 'package:calvin_boards/pages/signup_page.dart';
import 'package:calvin_boards/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repository/sign_up_repository.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _signUpRepository = SignUpRepository();

  bool notificacoes = true;
  bool modoNoturno = true;
  bool email = true;
  bool sms = true;
  bool _disposed = false;

  late SignUpProvider signUpProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    signUpProvider = Provider.of<SignUpProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Configurações"),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: ListView(children: [
          ListTile(
              title: const Text("Meu Perfil"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<SignUpProvider>.value(
                              value: context.read<SignUpProvider>(),
                              builder: (context, child) =>
                                  const MyAccountPage(),
                            )));
              }),
          SwitchListTile(
              activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
              title: const Text("Notificações"),
              value: notificacoes,
              onChanged: (state) {
                setState(() {
                  notificacoes = state;
                });
              }),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Tema Noturno"),
            value: modoNoturno,
            onChanged: (state) {
              setState(() {
                modoNoturno = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Enviar notificações por e-mail"),
            value: email,
            onChanged: (state) {
              setState(() {
                email = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Enviar notificações por SMS"),
            value: sms,
            onChanged: (state) {
              setState(() {
                sms = state;
              });
            },
          ),
          ListTile(
              textColor: Colors.red,
              title: const Text("Excluir Conta"),
              trailing: const Icon(
                Icons.delete_rounded,
                //color: Colors.red,
                size: 30,
              ),
              onTap: () {
                _buildConfirmationDialog(context);
              }),
        ]));
  }

  AlertDialog _buildConfirmationDialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Atenção"),
      content: const Text("Essa ação não pode ser desfeita. Deseja continuar?"),
      actions: [
        TextButton(
          child: const Text("Confirmar"),
          onPressed: () {
            Provider.of<SignUpProvider>(context, listen: false).remover();
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cadastro removido com sucesso')));
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
        ),
        TextButton(
            child: const Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
