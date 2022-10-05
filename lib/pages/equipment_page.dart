import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../components/default_drawer.dart';
import '../providers/signup_provider.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({Key? key}) : super(key: key);

  @override
  State<EquipmentPage> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //SignUp signUp = ModalRoute.of(context)!.settings.arguments as SignUp;
    return Scaffold(
        appBar: AppBar(title: const Text("Equipamentos")),
        drawer: ChangeNotifierProvider<SignUpProvider>.value(
            builder: (context, child) => DefaultDrawer(),
            value: Provider.of<SignUpProvider>(context)),
        body: _buildChart());
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
