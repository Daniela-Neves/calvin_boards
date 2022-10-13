import 'package:calvin_boards/models/sign_up.dart';
import 'package:calvin_boards/pages/home_page.dart';
import 'package:calvin_boards/providers/signup_provider.dart';
import 'package:calvin_boards/repository/sign_up_repository.dart';
import 'package:provider/provider.dart';

import '../pages/reset-password_page.dart';
import '../pages/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _scaniaIdController;
  late TextEditingController _senhaController;
  final repo = SignUpRepository();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _scaniaIdController = TextEditingController();
    _senhaController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            const SizedBox(
              width: 128,
              height: 128,
              child: Icon(
                Icons.insert_chart_outlined_outlined,
                color: Color(0xFF041E42),
                size: 100,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 40,
              child: Text(
                "Bem vindo de volta!",
                style: TextStyle(
                  color: Color(0xFF041E42),
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Form(
                key: _formkey,
                child: Column(children: [
                  _buildScaniaIdInput(),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildPaswordInput(),
                ])),
            Container(
              height: 50,
              alignment: Alignment.centerLeft,
              child: TextButton(
                child: const Text(
                  "Esqueceu a senha?",
                  style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.left,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordPage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                color: Color(0xFF16417F),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  onPressed: () async {
                    if (!_formkey.currentState!.validate()) {
                      return;
                    }
                    SignUp? usuario = await repo.login(
                        int.parse(_scaniaIdController.text),
                        _senhaController.text);

                    if (usuario == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Erro: id ou senha inválidos"),
                          backgroundColor: Colors.red));
                      _senhaController.text = '';
                      return;
                    }

                    Provider.of<SignUpProvider>(context, listen: false)
                        .setSignUp(usuario);

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                ChangeNotifierProvider<SignUpProvider>.value(
                                    value: context.watch<SignUpProvider>(),
                                    child: const HomePage()))));
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 40,
              child: Text(
                "Ou",
                style: TextStyle(
                  color: Color(0xFF041E42),
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 50,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                color: Color(0xFFFDFDFE),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  onPressed: () async {
                    SignUp? signUp = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    ) as SignUp;
                    setState(() {
                      _scaniaIdController.text = signUp.id.toString();
                    });
                  },
                  style: TextButton.styleFrom(
                    side: const BorderSide(width: 1.0, color: Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        "Registre-se",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _buildScaniaIdInput() {
    return TextFormField(
      // autofocus: true,
      controller: _scaniaIdController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null) {
          return "Digite uma ID.";
        }

        final regex = RegExp(r'^[0-9]+$');
        if (!regex.hasMatch(value)) {
          return "ID contém somente números.";
        }
      },
      decoration: const InputDecoration(
        labelText: "Scania ID:",
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      style: const TextStyle(fontSize: 20),
    );
  }

  TextFormField _buildPaswordInput() {
    return TextFormField(
      controller: _senhaController,
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) {
        if (value == null) {
          return "Digite sua senha.";
        }

        if (value.length < 4) {
          return "A senha contém no mínimo 4 caracteres.";
        }
      },
      decoration: const InputDecoration(
        labelText: "Senha:",
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      style: const TextStyle(fontSize: 20),
    );
  }
}
