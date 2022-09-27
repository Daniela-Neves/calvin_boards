import 'package:calvin_boards/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'equipment_page.dart';
import 'home_page.dart';

class AgriculturePage extends StatefulWidget {
  const AgriculturePage({Key? key}) : super(key: key);

  @override
  State<AgriculturePage> createState() => _AgriculturePageState();
}

class _AgriculturePageState extends State<AgriculturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Agricultura")),
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
            title: const Text("Configurações"),
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
        title: ChartTitle(text: 'Soja exportada por mês'),
        // Enable legend
        legend: Legend(isVisible: true),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<_Soja, String>>[
          LineSeries<_Soja, String>(
              dataSource: <_Soja>[
                _Soja('Jan', 35000),
                _Soja('Feb', 28000),
                _Soja('Mar', 34000),
                _Soja('Apr', 32000),
                _Soja('May', 40000),
                _Soja('Jun', 60000)
              ],
              xValueMapper: (_Soja soja, _) => soja.year,
              yValueMapper: (_Soja soja, _) => soja.soja,
              // Enable data label
              dataLabelSettings: const DataLabelSettings(isVisible: true))
        ]);
  }
}

class _Soja {
  _Soja(this.year, this.soja);

  final String year;
  final double soja;
}
