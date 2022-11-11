import 'package:eletroCar/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/default_drawer.dart';
import 'about_us.dart';
import 'car_list_page.dart';
import 'home_page.dart';

class InfoStellantisPage extends StatefulWidget {
  const InfoStellantisPage({Key? key}) : super(key: key);

  @override
  State<InfoStellantisPage> createState() => _InfoStellantisPageState();
}

class _InfoStellantisPageState extends State<InfoStellantisPage> {
  late SignUpProvider signUpProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    signUpProvider = Provider.of<SignUpProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _buildBottomNavigationBar(),
        appBar: AppBar(title: const Text("Stellantis")),
        drawer: ChangeNotifierProvider<SignUpProvider>.value(
            builder: (context, child) => DefaultDrawer(),
            value: Provider.of<SignUpProvider>(context)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/Logotipo-Stellantis_2.jpg'),
              const Text(
                "Stellantis é um grupo automotivo franco-ítalo-americano multinacional baseado nos Países Baixos, formado a partir da união da montadora ítalo-americana"
                "Fiat Chrysler Automobiles com a montadora francesa PSA Group, após a conclusão de um acordo de fusão 50-50. Registrado nos Países Baixos, o grupo reúne 14 marcas: "
                "Abarth, Alfa Romeo, Chrysler, Citroën, Dodge, DS, Fiat, Jeep, Lancia, Maserati, Opel, Peugeot, Ram e Vauxhall, "
                "com presença em mais de 130 países, com produção em 30 países."
                "Em termos de vendas globais de veículos em 2021, a Stellantis foi a quinta maior montadora do mundo atrás da Toyota, "
                "Volkswagen, Hyundai e General Motors.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ));
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
        onTap: (value) {
          if (value == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CarListPage()));
          } else if (value == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const InfoStellantisPage()));
          } else if (value == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AboutUsPage()));
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_car), label: "Veículos"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Stellantis"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Equipe")
        ]);
  }
}
