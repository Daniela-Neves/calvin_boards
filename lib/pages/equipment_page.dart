import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../components/default_drawer.dart';
import '../providers/notifications_provider.dart';
import '../providers/signup_provider.dart';
import 'notifications_page.dart';

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

  List<_Point> truckProduction2020 = [
    _Point('Jan	', 7169),
    _Point('Fev	', 9131),
    _Point('Mar	', 8406),
    _Point('Abr	', 403),
    _Point('Mai	', 4054),
    _Point('Jun	', 5575),
    _Point('Jul	', 6820),
    _Point('Ago	', 7087),
    _Point('Set	', 9430),
    _Point('Out	', 10902),
    _Point('Nov	', 11474),
    _Point('Dez	', 10485),
  ];

  List<_Point> truckProduction2021 = [
    _Point('Jan	', 8805),
    _Point('Fev	', 11805),
    _Point('Mar	', 12472),
    _Point('Abr	', 13093),
    _Point('Mai	', 13908),
    _Point('Jun	', 14639),
    _Point('Jul	', 14801),
    _Point('Ago	', 14963),
    _Point('Set	', 13816),
    _Point('Out	', 13733),
    _Point('Nov	', 14380),
    _Point('Dez	', 12395),
  ];

  List<_Point> truckProduction2022 = [
    _Point('Jan	', 9463),
    _Point('Fev	', 11389),
    _Point('Mar	', 13531),
    _Point('Abr	', 10072),
    _Point('Mai	', 13947),
    _Point('Jun	', 13370),
    _Point('Jul	', 12724),
    _Point('Ago	', 17223),
    _Point('Set	', 14956),
  ];

  final List<Map<String, dynamic>> reports = [
    {
      "title": "Produção de carros é maior que período pré-pandemia; "
          "recuperação é melhor que a dos carros",
      "number": 3,
    },
    {
      "title": "Diferença entre caminhões produzidos e licenciados se acentua",
      "number": 4
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Equipamentos"),
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

  Widget build2(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Equipamentos"),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            actions: <Widget>[
              IconButton(
                  icon: Badge(
                      badgeContent: Text(context
                          .watch<NotificationsProvider>()
                          .unreadCount()
                          .toString()),
                      child:
                          const Icon(Icons.notifications, color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NotificationsPage()));
                  })
            ]),
        drawer: ChangeNotifierProvider<SignUpProvider>.value(
            builder: (context, child) => DefaultDrawer(),
            value: Provider.of<SignUpProvider>(context)),
        body: Column(children: [
          Expanded(child: _buildChart()),
        ]));
  }

  Widget _buildChart() {
    return SfCartesianChart(
        margin:
            const EdgeInsets.only(top: 60, left: 40, right: 40, bottom: 100),
        primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: 'Caminhões produzidos por mês'),
        legend: Legend(
            isVisible: true,
            title: LegendTitle(
                alignment: ChartAlignment.center, text: "Fonte: ANFAVEA")),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<_Point, String>>[
          LineSeries<_Point, String>(
              color: Colors.red,
              markerSettings: const MarkerSettings(isVisible: true),
              name: "2020",
              dataSource: truckProduction2020,
              xValueMapper: (_Point value, _) => value.month,
              yValueMapper: (_Point value, _) => value.amount,
              dataLabelSettings: const DataLabelSettings(isVisible: true)),
          LineSeries<_Point, String>(
              color: Colors.blue,
              markerSettings: const MarkerSettings(isVisible: true),
              name: "2021",
              dataSource: truckProduction2021,
              xValueMapper: (_Point value, _) => value.month,
              yValueMapper: (_Point value, _) => value.amount,
              dataLabelSettings: const DataLabelSettings(isVisible: true)),
          LineSeries<_Point, String>(
              color: Colors.green,
              markerSettings: const MarkerSettings(isVisible: true),
              name: "2022",
              dataSource: truckProduction2022,
              xValueMapper: (_Point value, _) => value.month,
              yValueMapper: (_Point value, _) => value.amount)
        ]);
  }
}

class _Point {
  _Point(this.month, this.amount);

  final String month;
  final num amount;
}
