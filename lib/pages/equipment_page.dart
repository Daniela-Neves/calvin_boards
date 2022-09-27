import 'package:calvin_boards/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'agriculture_page.dart';
import 'home_page.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({Key? key}) : super(key: key);

  @override
  State<EquipmentPage> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Equipamentos")),
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
        title: ChartTitle(text: 'Equipamentos feitos por mês'),
        // Enable legend
        legend: Legend(isVisible: true),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<_Equipamentos, String>>[
          LineSeries<_Equipamentos, String>(
              dataSource: <_Equipamentos>[
                _Equipamentos('Jan', 300),
                _Equipamentos('Feb', 280),
                _Equipamentos('Mar', 340),
                _Equipamentos('Apr', 320),
                _Equipamentos('May', 400),
                _Equipamentos('Jun', 600)
              ],
              xValueMapper: (_Equipamentos caminhoes, _) => caminhoes.year,
              yValueMapper: (_Equipamentos caminhoes, _) => caminhoes.caminhoes,
              // Enable data label
              dataLabelSettings: const DataLabelSettings(isVisible: true))
        ]);
  }
}

class _Equipamentos {
  _Equipamentos(this.year, this.caminhoes);

  final String year;
  final double caminhoes;
}
