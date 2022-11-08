import 'package:eletroCar/pages/login_page.dart';
import 'package:eletroCar/pages/my_account_page.dart';
import 'package:eletroCar/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool notificacoes = true;

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
            title: const Text("Destravar as portas do carro"),
            value: notificacoes,
            onChanged: (state) {
              setState(() {
                notificacoes = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Travar as portas do carro"),
            value: notificacoes,
            onChanged: (state) {
              setState(() {
                notificacoes = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Ligar todas as luzes internas"),
            value: notificacoes,
            onChanged: (state) {
              setState(() {
                notificacoes = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Ligar faróis"),
            value: notificacoes,
            onChanged: (state) {
              setState(() {
                notificacoes = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Destravar o porta-malas"),
            value: notificacoes,
            onChanged: (state) {
              setState(() {
                notificacoes = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Enviar notificações por e-mail"),
            value: notificacoes,
            onChanged: (state) {
              setState(() {
                notificacoes = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Abrir vidro da direita do motorista"),
            value: notificacoes,
            onChanged: (state) {
              setState(() {
                notificacoes = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Abrir vidro da esquerda do motorista"),
            value: notificacoes,
            onChanged: (state) {
              setState(() {
                notificacoes = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Abrir vidro da direita do passageiro"),
            value: notificacoes,
            onChanged: (state) {
              setState(() {
                notificacoes = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Abrir vidro da esquerda do passageiro"),
            value: notificacoes,
            onChanged: (state) {
              setState(() {
                notificacoes = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Abrir todos os vidros"),
            value: notificacoes,
            onChanged: (state) {
              setState(() {
                notificacoes = state;
              });
            },
          ),
        ]));
  }
}
