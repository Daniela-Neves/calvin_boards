import 'package:calvin_boards/models/sign_up.dart';
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
                            ChangeNotifierProvider<SignUpProvider>(
                                builder: (context, child) =>
                                    const MyAccountPage(),
                                create: (_) => signUpProvider)));
              }),
          SwitchListTile(
              title: const Text("Notificações"),
              value: notificacoes,
              onChanged: (state) {
                setState(() {
                  notificacoes = state;
                });
              })
        ]));
  }

  Widget _buildConfig() {
    return ListView(
      children: [
        ListTile(
            title: const Text("Meu Perfil"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<SignUpProvider>(
                              child: const SignUpPage(),
                              create: (context) =>
                                  context.read<SignUpProvider>())));
            }),
        SwitchListTile(
            title: const Text("Notificações"),
            value: notificacoes,
            onChanged: (state) {
              setState(() {
                notificacoes = state;
              });
            })
      ],
    );
  }
/*
  Widget _buildConfig() {
    return Scaffold(
      body: FutureBuilder<List<SignUp>>(
        future: _futureSignUp,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final cadastros = snapshot.data ?? [];
            return ListView.separated(
              itemCount: cadastros.length,
              itemBuilder: (context, index) {
                final cadastro = cadastros[index];
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          await _signUpRepository.remover(cadastro.id!);

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Cadastro removido com sucesso')));

                          setState(() {
                            cadastros.removeAt(index);
                          });
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Remover',
                      ),
                      SlidableAction(
                        onPressed: (context) async {
                          var success = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => SignUpPage(
                                signUpParaEdicao: cadastro,
                              ),
                            ),
                          ) as bool?;

                          if (success != null && success) {
                            setState(() {
                              carregarCadastros();
                            });
                          }
                        },
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Editar',
                      ),
                    ],
                  ),
                  child: SignUpListItem(signUp: cadastro),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          }
          return Container();
        },
      ),
    );
  }*/
}
