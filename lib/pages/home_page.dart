import 'package:calvin_boards/components/default_drawer.dart';
import 'package:calvin_boards/models/sign_up.dart';
import 'package:calvin_boards/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SignUp signUp;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //SignUp signUp = ModalRoute.of(context)!.settings.arguments as SignUp;
    signUp = Provider.of<SignUpProvider>(context).getUsuario()!;

    return Scaffold(
        appBar: AppBar(title: const Text("Home")),
        drawer: ChangeNotifierProvider<SignUpProvider>(
            builder: (context, child) => DefaultDrawer(),
            create: (_) => SignUpProvider(signUp: signUp)),
        body: Container(child: _buildChart()));
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
