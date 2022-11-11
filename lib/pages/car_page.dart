import '../models/car.dart';
import '../repository/car_repository.dart';
import 'package:flutter/material.dart';

class CarPage extends StatefulWidget {
  Car? carParaEdicao;

   CarPage({Key? key, this.carParaEdicao}) : super(key: key);


  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  final _carRepository = CarRepository();
  final _manufacturerController = TextEditingController();
  final _modelController = TextEditingController();
  final _plateController = TextEditingController();
  final _yearController = TextEditingController();
  final _mileageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();

    final carro = widget.carParaEdicao;
    if (carro != null) {
      _modelController.text = carro.model;
      _plateController.text = carro.plate;
      _mileageController.text = carro.mileage.toString();
      _yearController.text = carro.year.toString();
      _manufacturerController.text = carro.manufacturer;
    }
  }

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
                const SizedBox(height: 80),
                _buildFabricante(),
                const SizedBox(height: 20),
                _buildModelo(),
                const SizedBox(height: 20),
                _buildPlaca(),
                const SizedBox(height: 20),
                _buildAno(),
                const SizedBox(height: 20),
                _buildMilha(),
                const SizedBox(height: 20),
                _buildButton(),
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

                  final fabricante = _manufacturerController.text;
                  final modelo = _modelController.text;
                  final placa = _plateController.text;

                  final car = Car(
                      manufacturer: fabricante, model: modelo, plate: placa, year: int.parse(_yearController.text), mileage: int.parse(_mileageController.text));

                    try {
                      if (widget.carParaEdicao != null) {
                        car.id = widget.carParaEdicao!.id;
                        await _carRepository.editarCarro(car);
                      } else {
                        await _carRepository.cadastrarCarro(car);
                      }

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Carro cadastrado com sucesso'),
                      ));

                      Navigator.of(context).pop(true);
                    } catch (e) {
                      Navigator.of(context).pop(false);
                    }
                },
              ),
            )));
  }

  TextFormField _buildModelo() {
    return TextFormField(
      controller: _modelController,
      decoration: const InputDecoration(
        labelText: 'Modelo',
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe o modelo do carro completo';
        }
        if (value.length < 2 || value.length > 80) {
          return 'O modelo deve ter entre 2 e 80 caracteres';
        }
        return null;
      },
    );
  }

  TextFormField _buildFabricante() {
    return TextFormField(
      controller: _manufacturerController,
      decoration: const InputDecoration(
        labelText: 'Fabricante',
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe o nome do fabricante do carro';
        }
        if (value.length < 2 || value.length > 80) {
          return 'O nome deve ter entre 2 e 80 caracteres';
        }
        return null;
      },
    );
  }

  TextFormField _buildPlaca() {
    return TextFormField(
      controller: _plateController,
      decoration: const InputDecoration(
        labelText: "Placa",
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe a placa do carro';
        }
        return null;
      },
    );
  }

  TextFormField _buildAno() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _yearController,
      decoration: const InputDecoration(
        labelText: "Ano",
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Informe o ano do carro";
        }
        return null;
      },
    );
  }


  TextFormField _buildMilha() {
    return TextFormField(
      controller: _mileageController,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: 'Quilômetros rodados',
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe a quilometragem do carro';
        }
        return null;
      },
    );
  }
}
