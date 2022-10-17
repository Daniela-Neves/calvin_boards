import 'package:calvin_boards/components/default_drawer.dart';
import 'package:calvin_boards/pages/notifications_page.dart';
import 'package:calvin_boards/providers/notifications_provider.dart';
import 'package:calvin_boards/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../models/sign_up.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String nome;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    SignUpProvider? signUpProvider =
        Provider.of<SignUpProvider>(context, listen: false);
    SignUp signUp = signUpProvider.getUsuario()!;
    nome = signUp.nome.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Home"), actions: <Widget>[
          IconButton(
              icon: Badge(
                  badgeContent: Text(context
                      .watch<NotificationsProvider>()
                      .unreadCount()
                      .toString()),
                  child: const Icon(Icons.notifications, color: Colors.white)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NotificationsPage()));
              })
        ]),
        drawer: ChangeNotifierProvider<SignUpProvider>.value(
            builder: (context, child) => DefaultDrawer(),
            value: Provider.of<SignUpProvider>(context)),
        body: ListView(
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: Consumer<SignUpProvider>(
                builder: (context, signUp, child) => Text(
                    "Seja bem vindo de volta, ${signUp.getPrimeiroNome()}!",
                    style: const TextStyle(fontSize: 18)),
              ),
            )),
            const Center(
                child: Padding(
              padding: EdgeInsets.only(top: 40, bottom: 30),
              child: Text("Comercialização de safras de 2021/2022",
                  style: TextStyle(fontSize: 18)),
            )),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_buildChart1(), _buildChart2(), _buildChart3()]),
            ),
          ],
        ));
  }

  Widget _buildChart1() {
    return Container(
      alignment: Alignment.centerLeft,
      child: CircularPercentIndicator(
        footer: const Text('Café'),
        radius: 45.0,
        lineWidth: 4.0,
        percent: 0.98,
        center: const Text("98%"),
        progressColor: Colors.red,
      ),
    );
  }

  Widget _buildChart2() {
    return Container(
      alignment: Alignment.center,
      child: CircularPercentIndicator(
        footer: const Text('Soja'),
        radius: 45.0,
        lineWidth: 4.0,
        percent: 0.79,
        center: const Text("79,20%"),
        progressColor: Colors.blue,
      ),
    );
  }

  Widget _buildChart3() {
    return Container(
      alignment: Alignment.centerRight,
      child: CircularPercentIndicator(
        footer: const Text('Milho'),
        radius: 45.0,
        lineWidth: 4.0,
        percent: 0.57,
        center: const Text("57,86%"),
        progressColor: Colors.yellow,
      ),
    );
  }
}
