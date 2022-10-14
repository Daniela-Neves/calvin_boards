import 'package:calvin_boards/components/default_drawer.dart';
import 'package:calvin_boards/pages/notifications_page.dart';
import 'package:calvin_boards/providers/notifications_provider.dart';
import 'package:calvin_boards/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:badges/badges.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  List<_Point> soyExports2021 = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Home"),
            actions: <Widget>[
          IconButton(
              icon: Badge(
                  badgeContent: Text(context
                      .watch<NotificationsProvider>()
                      .unreadCount()
                      .toString()),
                  child: const Icon(Icons.notifications, color: Colors.white)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NotificationsPage()));
              })
        ]),
        drawer: ChangeNotifierProvider<SignUpProvider>.value(
            builder: (context, child) => DefaultDrawer(),
            value: Provider.of<SignUpProvider>(context)),
        body:
        Column
          (children: [
          Expanded(child:
            _buildChart()),
        ]));
  }

  Widget _buildChart() {
    return Container(
      child: SfCartesianChart(
        margin:
            const EdgeInsets.only(top: 60, left: 40, right: 40, bottom: 100),
        primaryYAxis: NumericAxis(
            title: AxisTitle(text: "Milhões de toneladas"),
            numberFormat: NumberFormat.compact()),
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: 'Soja exportada por mês'),
        legend: Legend(
            isVisible: true,
            title: LegendTitle(
                alignment: ChartAlignment.center,
                text:
                    "Exportação de soja caiu 21% em 2022.\nFonte: Comex Stat - MDIC")),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<_Point, String>>[
          LineSeries<_Point, String>(
              color: Colors.blue,
              markerSettings: const MarkerSettings(isVisible: true),
              name: "2021",
              dataSource: soyExports2021,
              xValueMapper: (_Point value, _) => value.month,
              yValueMapper: (_Point value, _) => value.amount.round(),
              dataLabelSettings: const DataLabelSettings(isVisible: true)),
          LineSeries<_Point, String>(
              color: Colors.green,
              markerSettings: const MarkerSettings(isVisible: true),
              name: "2022",
              dataSource: <_Point>[
                _Point('Jan', 2451.828),
                _Point('Fev', 6274.365),
                _Point('Mar', 12232.570),
                _Point('Abr', 11481.981),
                _Point('Mai', 10657.844),
                _Point('Jun', 10088.221),
                _Point('Jul', 7561.542),
                _Point('Ago', 6117.405),
                _Point('Set', 4292.326),
              ],
              xValueMapper: (_Point value, _) => value.month,
              yValueMapper: (_Point value, _) => value.amount.round()),
          AreaSeries(
              name: "Período de alta",
              color: const Color.fromARGB(19, 244, 67, 54),
              dataSource: soyExports2021.sublist(2, 6),
              xValueMapper: (_Point value, _) => value.month,
              yValueMapper: (_Point value, _) => value.amount)
        ]));
  }

}

class _Point {
  _Point(this.month, this.amount);

  final String month;
  final num amount;
}
