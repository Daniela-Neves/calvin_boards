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
                color: Color(0xFFF85F6A),
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
                  color: Color(0xFFF85F6A),
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            _buildScaniaIdInput(),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              // autofocus: true,
              controller: _senhaController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Senha:",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(fontSize: 20),
            ),
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
              height: 30,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                //color: Color(0xFFF85F6A),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
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
              height: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 40,
              child: Text(
                "Ou",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  //color: Color(0xFFF85F6A),
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40,
              child: TextButton(
                child: const Text(
                  "Registre-se",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF85F6A),
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScaniaIdInput() {
    return TextFormField(
      // autofocus: true,
      controller: _scaniaIdController,
      keyboardType: TextInputType.number,
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
}
