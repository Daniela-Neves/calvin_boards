import 'package:eletroCar/models/car.dart';
import 'package:eletroCar/pages/car_page.dart';
import 'package:eletroCar/repository/car_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../components/car_item.dart';
import '../components/default_drawer.dart';
import '../providers/signup_provider.dart';
import 'about_us.dart';
import 'info_stellantis.dart';


class CarListPage extends StatefulWidget {
  const CarListPage({Key? key}) : super(key: key);

  @override
  State<CarListPage> createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  final _carRepository = CarRepository();
  late Future<List<Car>> _futureCar;

  @override
  void initState() {
    carregarCarros();
    super.initState();
  }

  void carregarCarros() {
    _futureCar = _carRepository.listarCarro();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      appBar: AppBar(title: const Text("Carro")),
      drawer: ChangeNotifierProvider<SignUpProvider>.value(
          builder: (context, child) => DefaultDrawer(),
          value: Provider.of<SignUpProvider>(context)),
      body: FutureBuilder<List<Car>>(
        future: _futureCar,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final cars = snapshot.data ?? [];
            return ListView.separated(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          await _carRepository
                              .removerCarro(car.id!);

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Carro removido com sucesso')));

                          setState(() {
                            cars.removeAt(index);
                          });
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Remover',
                      ),
                      SlidableAction(
                        onPressed: (context) async {
                          var success = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CarPage(
                                    carParaEdicao: car,
                              ),
                            ),
                          ) as bool?;

                          if (success != null && success) {
                            setState(() {
                              carregarCarros();
                            });
                          }
                        },
                        backgroundColor: Color(0xFFFFCD12),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Editar',
                      ),
                    ],
                  ),
                  child: CarListItem(car: car),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool? carroCadastrado = await Navigator.of(context)
                .pushNamed('/carro-cadastro') as bool?;

            if (carroCadastrado != null && carroCadastrado) {
              setState(() {
                carregarCarros();
              });
            }
          },
          child: const Icon(Icons.add)),
    );
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

