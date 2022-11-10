import 'package:eletroCar/pages/login_page.dart';
import 'package:eletroCar/pages/my_account_page.dart';
import 'package:eletroCar/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool portas = true;
  bool luzes = true;
  bool ligarFarois = true;
  bool piscarFarois = true;
  bool portaMalas = true;
  bool alarme = true;

  double _vidroDireitaMotorista = 20;
  double _vidroEsquerdaMotorista = 20;
  double _vidroDireitaPassageiro = 20;
  double _vidroEsquerdaPassageiro = 20;

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
            title: const Text("Controle"),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: ListView(children: [
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Travar as portas do carro"),
            value: portas,
            onChanged: (state) {
              setState(() {
                portas = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Ligar todas as luzes internas"),
            value: luzes,
            onChanged: (state) {
              setState(() {
                luzes = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Ligar faróis"),
            value: ligarFarois,
            onChanged: (state) {
              setState(() {
                ligarFarois = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Piscar faróis"),
            value: piscarFarois,
            onChanged: (state) {
              setState(() {
                piscarFarois = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Destravar o porta-malas"),
            value: portaMalas,
            onChanged: (state) {
              setState(() {
                portaMalas = state;
              });
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).toggleButtonsTheme.selectedColor,
            title: const Text("Disparar alarme"),
            value: alarme,
            onChanged: (state) {
              setState(() {
                alarme = state;
              });
            },
          ),
          const Divider(
            height: 20,
          ),
          Container(
            padding: const EdgeInsetsDirectional.only(start: 20),
            height: 40,
            child: const Text(
                style: TextStyle(fontSize: 17),
                "Abrir vidros:",
                textAlign: TextAlign.justify),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                  style: TextStyle(fontSize: 16),
                  "Direita do motorista",
                  textAlign: TextAlign.justify),
              Slider(
                value: _vidroDireitaMotorista,
                max: 100,
                divisions: 10,
                label: _vidroDireitaMotorista.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _vidroDireitaMotorista = value;
                  });
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                  style: TextStyle(fontSize: 16),
                  "Esquerda do motorista",
                  textAlign: TextAlign.justify),
              Slider(
                value: _vidroEsquerdaMotorista,
                max: 100,
                divisions: 10,
                label: _vidroEsquerdaMotorista.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _vidroEsquerdaMotorista = value;
                  });
                },
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                  style: TextStyle(fontSize: 16),
                  "Direita do passageiro",
                  textAlign: TextAlign.justify),
              Slider(
                value: _vidroDireitaPassageiro,
                max: 100,
                divisions: 10,
                label: _vidroDireitaPassageiro.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _vidroDireitaPassageiro = value;
                  });
                },
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                  style: TextStyle(fontSize: 16),
                  "Esquerda do passageiro",
                  textAlign: TextAlign.justify),
              Slider(
                value: _vidroEsquerdaPassageiro,
                max: 100,
                divisions: 10,
                label: _vidroEsquerdaPassageiro.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _vidroEsquerdaPassageiro = value;
                  });
                },
              ),
            ],
          ),
        ]));
  }
}
