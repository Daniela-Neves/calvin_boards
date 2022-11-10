import 'package:eletroCar/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/default_drawer.dart';
import 'home_page.dart';
import 'info_stellantis.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
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
        appBar: AppBar(title: const Text("Equipe")),
        drawer: ChangeNotifierProvider<SignUpProvider>.value(
            builder: (context, child) => DefaultDrawer(),
            value: Provider.of<SignUpProvider>(context)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text("Daniela Neves Santos",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
              Text("RM - 86381",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
              Divider(
                height: 15,
              ),
              Text("Geovanne Douglas Macario Santos de Macedo",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
              Text("RM - 86306",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
              Divider(
                height: 15,
              ),
              Text("Nicolas Morais Santos",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
              Text("RM - 84393",
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
                MaterialPageRoute(builder: (context) => const HomePage()));
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
