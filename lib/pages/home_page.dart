import 'package:calvin_boards/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'agriculture_page.dart';
import 'equipment_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Home")),
        drawer: _buildDrawer(),
        body: Container(child: _buildChart()));
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          const UserAccountsDrawerHeader(
              accountName: Text("Calvin Santos"),
              accountEmail: Text("calvinboard.com.br")),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            leading: const Icon(Icons.emoji_nature),
            title: const Text("Agricultura"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AgriculturePage(),
                ),
              );
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            leading: const Icon(Icons.agriculture),
            title: const Text("Equipamentos"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EquipmentPage(),
                ),
              );
            },
          ),
          const SizedBox(
              //height: 200,
              ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            leading: const Icon(Icons.miscellaneous_services),
            title: const Text("Configura????es"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                trailing: const Icon(Icons.arrow_forward_ios),
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Sair"),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    return SfCartesianChart(
        margin:
        const EdgeInsets.only(top: 60, left: 40, right: 40, bottom: 100),
        primaryXAxis: CategoryAxis(),
        // Chart title
        title: ChartTitle(text: 'Soja exportada por m??s'),
        // Enable legend
        legend: Legend(isVisible: true),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<_Plantacao, String>>[
          LineSeries<_Plantacao, String>(
              dataSource: <_Plantacao>[
                _Plantacao('Jan', 35000),
                _Plantacao('Feb', 28000),
                _Plantacao('Mar', 34000),
                _Plantacao('Apr', 32000),
                _Plantacao('May', 40000),
                _Plantacao('Jun', 60000)
              ],
              xValueMapper: (_Plantacao soja, _) => soja.year,
              yValueMapper: (_Plantacao soja, _) => soja.soja,
              // Enable data label
              dataLabelSettings: const DataLabelSettings(isVisible: true))
        ]);
  }
}

class _Plantacao {
  _Plantacao(this.year, this.soja);

  final String year;
  final double soja;
}
