import 'package:email_validator/email_validator.dart';
import '../models/sign_up.dart';
import '../repository/sign_up_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpRepository = SignUpRepository();
  final _scaniaIdController = TextEditingController();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _celularController = TextEditingController();
  final _dataController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(height: 50),
                _buildScaniaId(),
                const SizedBox(height: 20),
                _buildNome(),
                const SizedBox(height: 20),
                _buildEmail(),
                const SizedBox(height: 20),
                _buildSenha(),
                const SizedBox(height: 20),
                _buildDataNascimento(),
                const SizedBox(height: 20),
                _buildCelular(),
                const SizedBox(height: 20),
                _buildButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildButton() {
    return SizedBox(
        child: Container(
            height: 60,
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              color: Color(0xFF041E42),
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
                      "Cadastrar",
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
                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) {
                    return;
                  }
                  final nome = _nomeController.text;
                  final celular = _celularController.text;
                  final data =
                      DateFormat('dd/MM/yyyy').parse(_dataController.text);
                  final email = _emailController.text;
                  final senha = _senhaController.text;

                  final signUp = SignUp(
                      id: int.parse(_scaniaIdController.text),
                      email: email,
                      nome: nome,
                      celular: celular,
                      data: data,
                      senha: senha);

                  try {
                    await _signUpRepository.cadastrar(signUp);

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Cadastro efetuado.'),
                    ));

                    Navigator.of(context).pop(signUp);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Essa ID já está cadastrada.")));
                  }
                },
              ),
            )));
  }

  TextFormField _buildScaniaId() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _scaniaIdController,
      decoration: const InputDecoration(
        labelText: 'ScaniaID',
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe sua ID Scania';
        }
        if (value.length != 8) {
          return 'ID Scania tem 8 caracteres';
        }
        return null;
      },
    );
  }

  TextFormField _buildNome() {
    return TextFormField(
      controller: _nomeController,
      decoration: const InputDecoration(
        labelText: 'Nome',
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe seu nome completo';
        }
        if (value.length < 2 || value.length > 80) {
          return 'O nome deve ter entre 2 e 80 caracteres';
        }
        return null;
      },
    );
  }

  TextFormField _buildCelular() {
    return TextFormField(
      controller: _celularController,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: 'Celular',
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        String patttern = r'(^[0-9]*$)';
        RegExp regExp = RegExp(patttern);
        if (value == null || value.isEmpty) {
          return 'Informe o número do seu celular';
        } else if (!regExp.hasMatch(value)) {
          return "O número do celular só deve conter dígitos";
        }

        return null;
      },
    );
  }

  TextFormField _buildDataNascimento() {
    return TextFormField(
      controller: _dataController,
      decoration: const InputDecoration(
        labelText: 'Data de Nascimento',
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());

        DateTime? dataSelecionada = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1920),
          lastDate: DateTime.now(),
        );

        if (dataSelecionada != null) {
          _dataController.text =
              DateFormat('dd/MM/yyyy').format(dataSelecionada);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe sua data de nascimento';
        }

        try {
          DateFormat('dd/MM/yyyy').parse(value);
        } on FormatException {
          return 'Formato de data inválida';
        }

        return null;
      },
    );
  }

  TextFormField _buildEmail() {
    return TextFormField(
      //keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: "E-mail",
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Informe seu email";
        } else if (!EmailValidator.validate(value)) {
          return 'Formato de email inválido';
        }
        return null;
      },
    );
  }

  TextFormField _buildSenha() {
    return TextFormField(
      //keyboardType: TextInputType.text,
      controller: _senhaController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: "Senha",
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Informe sua senha";
        }
        return null;
      },
    );
  }
}
