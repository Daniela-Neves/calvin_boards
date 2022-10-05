import 'package:calvin_boards/pages/agriculture_page.dart';
import 'package:calvin_boards/pages/equipment_page.dart';
import 'package:calvin_boards/pages/home_page.dart';
import 'package:calvin_boards/pages/settings.dart';
import 'package:calvin_boards/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultDrawer extends Drawer {
  DefaultDrawer({super.key});

  List<Page> pages = [
    Page(
        nome: "Home",
        icone: Icons.home,
        builder: (context) => const HomePage()),
    Page(
        nome: "Agricultura",
        icone: Icons.emoji_nature,
        builder: (context) => const AgriculturePage())
  ];

  @override
  Widget build(BuildContext context) {
    //SignUp signUp = Provider.of<SignUpProvider>(context).getUsuario()!;

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName:
                  Text(context.watch<SignUpProvider>().getUsuario()!.nome),
              accountEmail: Text(context.watch<SignUpProvider>().getUsuario()!.email)),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            leading: const Icon(Icons.emoji_nature),
            title: const Text("Agricultura"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AgriculturePage(),
                ),
              );
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            leading: const Icon(Icons.agriculture),
            title: const Text("Equipamentos"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EquipmentPage(),
                ),
              );
            },
          ),
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
