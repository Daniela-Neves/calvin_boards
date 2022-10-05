import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
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

  @override
  Widget build(BuildContext context) {
    //SignUp signUp = ModalRoute.of(context)!.settings.arguments as SignUp;
    return Scaffold(
        appBar: AppBar(title: const Text("Agricultura")),
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
