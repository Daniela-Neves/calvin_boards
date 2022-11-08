import 'package:eletroCar/pages/home_page.dart';
import 'package:eletroCar/pages/settings.dart';
import 'package:eletroCar/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/control.dart';

class DefaultDrawer extends Drawer {
  DefaultDrawer({super.key});

  final List<Page> pages = [
    Page(
        nome: "Home",
        icone: Icons.home,
        builder: (context) => const HomePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Consumer<SignUpProvider>(
              builder: (BuildContext context, signUp, child) =>
                  UserAccountsDrawerHeader(
                      accountName: Text(signUp.getNome()),
                      accountEmail: Text(signUp.getEmail()))),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            leading: const Icon(Icons.map_sharp),
            title: const Text("Mapa"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          /*ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            leading: const Icon(Icons.agriculture),
            title: const Text("Pontos de Recarga"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EquipmentPage(),
                ),
              );
            },
          ),*/
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            leading: const Icon(Icons.control_camera_sharp),
            title: const Text("Controle"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ControlPage(),
                ),
              );
            },
          ),
          /*ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            leading: const Icon(Icons.agriculture),
            title: const Text("Dicas"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EquipmentPage(),
                ),
              );
            },
          ),*/
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            leading: const Icon(Icons.miscellaneous_services),
            title: const Text("Configurações"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>
                          ChangeNotifierProvider<SignUpProvider>.value(
                              value: context.watch<SignUpProvider>(),
                              builder: (context, child) =>
                                  const SettingsPage()))));
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  ListTile(
                    trailing: const Icon(Icons.arrow_forward_ios),
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text("Sair"),
                    onTap: () {
                      //SystemNavigator.pop();
                      Navigator.of(context).pushNamed('/login');
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Você fez logout. Até logo."),
                          backgroundColor: Colors.green));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Page {
  String nome;
  IconData icone;
  Widget Function(BuildContext?) builder;

  Page({required this.nome, required this.icone, required this.builder});
}
