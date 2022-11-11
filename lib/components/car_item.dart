import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/car.dart';

class CarListItem extends StatelessWidget {
  final Car car;
  const CarListItem({Key? key, required this.car})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(car.manufacturer),
      subtitle: Text(car.model),
      onTap: () {
        Navigator.pushNamed(context, '/carro-detalhes',
            arguments: car);
      },
    );
  }
}
