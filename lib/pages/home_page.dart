import 'package:eletroCar/components/default_drawer.dart';
import 'package:eletroCar/providers/signup_provider.dart';
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
        appBar: AppBar(title: const Text("Home")),
        drawer: ChangeNotifierProvider<SignUpProvider>.value(
            builder: (context, child) => DefaultDrawer(),
            value: Provider.of<SignUpProvider>(context)),
        body: ListView(
          children: const [
            Center(
                child: Padding(
              padding: EdgeInsets.only(top: 30, bottom: 20),
            )),
          ],
        ));
  }
}
