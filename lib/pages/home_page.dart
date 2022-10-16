import 'package:calvin_boards/components/default_drawer.dart';
import 'package:calvin_boards/pages/notifications_page.dart';
import 'package:calvin_boards/providers/notifications_provider.dart';
import 'package:calvin_boards/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
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

  List<_Point> soyExports2021 = [
    _Point('Jan', 49.606),
    _Point('Fev', 2646.546),
    _Point('Mar', 12694.341),
    _Point('Abr', 16619.467),
    _Point('Mai', 15465.736),
    _Point('Jun', 11568.091),
    _Point('Jul', 8675.830),
    _Point('Ago', 6480.259),
    _Point('Set', 4858.458),
    _Point('Out', 3294.671),
    _Point('Nov', 2605.951),
    _Point('Dez', 2739.225),
  ];

  List<_Point> soyExports2022 = [
    _Point('Jan', 2451.828),
    _Point('Fev', 6274.365),
    _Point('Mar', 12232.570),
    _Point('Abr', 11481.981),
    _Point('Mai', 10657.844),
    _Point('Jun', 10088.221),
    _Point('Jul', 7561.542),
    _Point('Ago', 6117.405),
    _Point('Set', 4292.326),
  ];

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
            const Center(
                child: Padding(
              padding: EdgeInsets.only(top: 15, bottom: 20),
              child: Text("Seja bem vindo de volta!",
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
        footer: const Text('Tal coisa'),
        radius: 45.0,
        lineWidth: 4.0,
        percent: 0.10,
        center: const Text("10%"),
        progressColor: Colors.red,
      ),
    );
  }

  Widget _buildChart2() {
    return Container(
      alignment: Alignment.center,
      child: CircularPercentIndicator(
        footer: const Text('Soja 2021/2022'),
        radius: 45.0,
        lineWidth: 4.0,
        percent: 0.80,
        center: const Text("79,20%"),
        progressColor: Colors.blue,
      ),
    );
  }

  Widget _buildChart3() {
    return Container(
      alignment: Alignment.centerRight,
      child: CircularPercentIndicator(
        footer: const Text('Tal coisa'),
        radius: 45.0,
        lineWidth: 4.0,
        percent: 0.50,
        center: const Text("50%"),
        progressColor: Colors.yellow,
      ),
    );
  }
}

class _Point {
  _Point(this.month, this.amount);

  final String month;
  final num amount;
}
