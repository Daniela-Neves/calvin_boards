import 'package:eletroCar/pages/login_page.dart';
import 'package:eletroCar/pages/my_account_page.dart';
import 'package:eletroCar/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificacoes = true;
  bool modoNoturno = true;
  bool email = true;
  bool sms = true;

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
                showAlertDialog(context);
              }),
        ]));
  }

  showAlertDialog(BuildContext context) {
    Widget cancelaButton = TextButton(
      child: Text("Cancelar"),
        onPressed: () {
          Navigator.of(context).pop();
        }
    );
    Widget continuaButton = TextButton(
      child: Text("Continuar"),
        onPressed: () {
          Provider.of<SignUpProvider>(context, listen: false).remover();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cadastro removido com sucesso')));
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Atenção"),
      content: Text("Essa ação não pode ser desfeita. Deseja continuar?"),
      actions: [
        cancelaButton,
        continuaButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
