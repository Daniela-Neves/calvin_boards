import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/default_drawer.dart';
import '../providers/signup_provider.dart';

class AgriculturePage extends StatefulWidget {
  const AgriculturePage({Key? key}) : super(key: key);

  @override
  State<AgriculturePage> createState() => _AgriculturePageState();
}

class _AgriculturePageState extends State<AgriculturePage> {
  @override
  void initState() {
    super.initState();
  }

  final List<_Point> soyExports2021 = [
    _Point('Jan', 49.606),
    _Point('Fev', 2646.546),
    _Point('Mar', 12694.341),
    _Point('Abr', 16619.467),
    _Point('Mai', 15465.736),
    _Point('Jun', 11568.091),
    _Point('Jul', 8675.830),
    _Point('Ago', 6480.259),
    _Point('Set', 4858.458),
    _Point('Out', 3294.671),
    _Point('Nov', 2605.951),
    _Point('Dez', 2739.225),
  ];

  final List<_Point> soyExports2022 = [
    _Point('Jan', 2451.828),
    _Point('Fev', 6274.365),
    _Point('Mar', 12232.570),
    _Point('Abr', 11481.981),
    _Point('Mai', 10657.844),
    _Point('Jun', 10088.221),
    _Point('Jul', 7561.542),
    _Point('Ago', 6117.405),
    _Point('Set', 4292.326),
  ];

  final List<Map<String, dynamic>> reports = [
    {"title": "Exportação de soja cai 21% em 2022", "number": 1},
    {
      "title": "Produção de cana-de-açúcar tende a desaparecer no Paraná",
      "number": 2
    },
    {
      "title": "Chuvas em SP despencam e comprometem produtividade da cana",
      "number": 3
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Agricultura"),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                })),
        drawer: ChangeNotifierProvider<SignUpProvider>.value(
            builder: (context, child) => DefaultDrawer(),
            value: Provider.of<SignUpProvider>(context)),
        body: _buildListView());
  }

  ListView _buildListView() {
    return ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) => ListTile(
            title: Text(reports[index]["title"]),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pushNamed('/report_details',
                  arguments: reports[index]["number"]);
            }));
  }
}

class _Point {
  _Point(this.month, this.amount);

  final String month;
  final num amount;
}
