import '../models/car.dart';
import 'package:flutter/material.dart';

class CarDetailsPage extends StatelessWidget {
  const CarDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context)!.settings.arguments as Car;

    return Scaffold(
      appBar: AppBar(
        title: Text(car.model),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Placa'),
              subtitle: Text(
                  car.plate.isEmpty ? '-' : car.plate),
            ),
            ListTile(
              title: const Text('Modelo'),
              subtitle: Text(
                  car.model.isEmpty ? '-' : car.model),
            ),
            ListTile(
              title: const Text('Fabricante'),
              subtitle: Text(
                  car.manufacturer.isEmpty ? '-' : car.manufacturer),
            ),
            ListTile(
              title: const Text('Ano'),
              subtitle: Text(
                  car.year.toString()),
            ),
            ListTile(
              title: const Text('Quilômetros rodados'),
              subtitle: Text(
                  car.mileage.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
