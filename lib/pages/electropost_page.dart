import 'package:eletroCar/models/electropost.dart';
import 'package:flutter/material.dart';
import '../api/api.dart';

class ElectropostPage extends StatefulWidget {
  const ElectropostPage({Key? key}) : super(key: key);

  int? get id => null;
  String? get nome => null;
  String? get informacoes => null;
  String? get endereco => null;
  String? get telefone => null;
  List<String>? get conectores => null;

  @override
  State<ElectropostPage> createState() => ElectropostPageState();
}

class ElectropostPageState extends State<ElectropostPage> {
  final api = API();
  late Future<List<Electropost>> _futureElectropost;

  @override
  void initState() {
    _futureElectropost = api.findElectropost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eletroposto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
              child: FutureBuilder<List<Electropost>>(
                future: _futureElectropost,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    var followings = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: followings.length,
                      itemBuilder: ((context, index) {
                        var electroposts = followings[index];
                        return Column(
                          children: [
                             Text(
                              electroposts.nome,
                              style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              electroposts.endereco,
                              style: const TextStyle(color: Colors.black),
                            ),
                            Text(
                              electroposts.telefone,
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(height: 30),
                          ],
                        );
                      }),
                    );
                  }
                },
              ))
        ]),
      ),
    );
  }
}