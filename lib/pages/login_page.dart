import 'package:eletroCar/models/sign_up.dart';
import 'package:eletroCar/pages/home_page.dart';
import 'package:eletroCar/providers/signup_provider.dart';
import 'package:eletroCar/providers/theme_provider.dart';
import 'package:eletroCar/repository/sign_up_repository.dart';
import 'package:provider/provider.dart';

import 'reset_password_page.dart';
import '../pages/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _senhaController;
  final repo = SignUpRepository();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _senhaController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
        //color: Theme.of(context).backgroundColor,
        child: ListView(
          children: <Widget>[
            Container(
                height: 20,
                color: Theme.of(context).appBarTheme.backgroundColor,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  _buildThemeSwitcherIcon(context),
                  Switch(
                    value: context.watch<ThemeProvider>().isDark(),
                    onChanged: (value) {
                      context.read<ThemeProvider>().toggleDark();
                    },
                  )
                ])),
            Column(
              children: const [
                Icon(
                  Icons.flash_on,
                  color: Color(0xFFFFCD12),
                  size: 100,
                ),
                Text("EletroCar",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
                key: _formkey,
                child: Column(children: [
                  _buildEmailInput(),
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
                  "Esqueceu sua senha?",
                  style: TextStyle(
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
                color: Color(0xFFFFCD12),
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
                        _emailController.text, _senhaController.text);

                    if (usuario == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Erro: email ou senha inválidos"),
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
                      _emailController.text = signUp.email.toString();
                    });
                  },
                  style: TextButton.styleFrom(
                    side: const BorderSide(width: 1.0, color: Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        "Cadastre-se",
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

  TextFormField _buildEmailInput() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: "Email:",
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      style: const TextStyle(fontSize: 20),
    );
  }

  Icon _buildThemeSwitcherIcon(BuildContext context) {
    if (context.read<ThemeProvider>().isDark()) {
      return const Icon(Icons.light_mode);
    }
    return const Icon(Icons.dark_mode);
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
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Senha:",
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      style: const TextStyle(fontSize: 20),
    );
  }
}
