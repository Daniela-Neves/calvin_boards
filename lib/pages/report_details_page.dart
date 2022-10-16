import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:calvin_boards/repository/agriculture_repository.dart';
import 'package:calvin_boards/repository/equipment_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:path_provider/path_provider.dart';

class ReportDetailsPage extends StatefulWidget {
  const ReportDetailsPage({Key? key}) : super(key: key);

  @override
  State<ReportDetailsPage> createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage> {
  final List<Point> soyExports2021 = [
    Point('Jan', 49.606),
    Point('Fev', 2646.546),
    Point('Mar', 12694.341),
    Point('Abr', 16619.467),
    Point('Mai', 15465.736),
    Point('Jun', 11568.091),
    Point('Jul', 8675.830),
    Point('Ago', 6480.259),
    Point('Set', 4858.458),
    Point('Out', 3294.671),
    Point('Nov', 2605.951),
    Point('Dez', 2739.225),
  ];

  final List<Point> soyExports2022 = [
    Point('Jan', 2451.828),
    Point('Fev', 6274.365),
    Point('Mar', 12232.570),
    Point('Abr', 11481.981),
    Point('Mai', 10657.844),
    Point('Jun', 10088.221),
    Point('Jul', 7561.542),
    Point('Ago', 6117.405),
    Point('Set', 4292.326),
  ];

  @override
  Widget build(BuildContext context) {
    int reportNumber = ModalRoute.of(context)!.settings.arguments as int;
    return _scaffoldBuilder(context, reportNumber);
  }

  Widget _scaffoldBuilder(BuildContext context, int reportNumber) {
    Widget reportWidget;

    switch (reportNumber) {
      case 1:
        reportWidget = _buildAgroReport1();
        break;
      case 2:
        reportWidget = _buildAgroReport2();
        break;
      case 3:
        reportWidget = _buildEquipReport3();
        break;
      case 4:
        reportWidget = _buildEquipReport4();
        break;
      default:
        reportWidget = const Text("Nenhum relatório especificado.");
    }
    ScreenshotController screenshotController = ScreenshotController();

    return Screenshot(
        controller: screenshotController,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            title: const Text("Relatório"),
            actions: [
              IconButton(
                  onPressed: () {
                    takePicture(screenshotController);
                  },
                  icon: const Icon(Icons.share))
            ],
          ),
          body: reportWidget,
        ));
  }

  Future<void> takePicture(ScreenshotController controller) async {
    await controller.capture().then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath =
            await File('${directory.path}/relatorio.png').create();
        await imagePath.writeAsBytes(image);

        await Share.shareFiles([imagePath.path],
            text: 'Veja esse relatório do Calvin Boards');
      }
    });
  }

  Widget _buildAgroReport1() {
    return Column(
      children: [
        Expanded(
          child: SfCartesianChart(
              margin: const EdgeInsets.only(
                  top: 60, left: 40, right: 40, bottom: 100),
              primaryYAxis: NumericAxis(
                  title: AxisTitle(text: "Milhões de toneladas"),
                  numberFormat: NumberFormat.compact()),
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Soja exportada por mês'),
              legend: Legend(
                  isVisible: true,
                  title: LegendTitle(
                      alignment: ChartAlignment.center,
                      text: "Fonte: Comex Stat - MDIC")),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<Point, String>>[
                LineSeries<Point, String>(
                    color: Colors.blue,
                    markerSettings: const MarkerSettings(isVisible: true),
                    name: "2021",
                    dataSource: soyExports2021,
                    xValueMapper: (Point value, _) => value.month,
                    yValueMapper: (Point value, _) => value.amount.round(),
                    dataLabelSettings:
                        const DataLabelSettings(isVisible: true)),
                LineSeries<Point, String>(
                    color: Colors.green,
                    markerSettings: const MarkerSettings(isVisible: true),
                    name: "2022",
                    dataSource: soyExports2022,
                    xValueMapper: (Point value, _) => value.month,
                    yValueMapper: (Point value, _) => value.amount.round()),
                AreaSeries(
                    name: "Período de alta",
                    color: const Color.fromARGB(19, 244, 67, 54),
                    dataSource: soyExports2021.sublist(2, 6),
                    xValueMapper: (Point value, _) => value.month,
                    yValueMapper: (Point value, _) => value.amount)
              ]),
        ),
        const Text(
            "Dados do Ministério da Indústria, Comércio Exterior e Serviços "
            "mostram uma queda significativa das exportações de soja no período"
            " de colheita")
      ],
    );
  }

  Widget _buildAgroReport2() {
    final repo = AgricultureRepository();
    return Column(children: [
      FutureBuilder(
          future: repo.getData("Cana", "Paraná"),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return Expanded(
              child: SfCartesianChart(
                  margin: const EdgeInsets.only(
                      top: 60, left: 40, right: 40, bottom: 100),
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(text: "Toneladas"),
                      numberFormat: NumberFormat.compact()),
                  primaryXAxis: CategoryAxis(),
                  axes: [
                    NumericAxis(
                        title: AxisTitle(text: "Área plantada (hectare)"),
                        name: "cropArea",
                        numberFormat: NumberFormat.compact(),
                        opposedPosition: true),
                  ],
                  title: ChartTitle(
                      text: 'Cana produzida e área plantada por mês'),
                  legend: Legend(
                      isVisible: true,
                      title: LegendTitle(
                          alignment: ChartAlignment.center,
                          text: "Fonte: IBGE")),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<AgricultureRow, String>>[
                    LineSeries<AgricultureRow, String>(
                        color: Colors.blue,
                        markerSettings: const MarkerSettings(isVisible: false),
                        name: "Produção",
                        dataSource: snapshot.data as List<AgricultureRow>,
                        xValueMapper: (AgricultureRow value, int idx) {
                          {
                            if (idx > 130) return "2024-03";
                            return value.yearMonth;
                          }
                        },
                        yValueMapper: (AgricultureRow value, _) =>
                            value.cropYield,
                        trendlines: <Trendline>[
                          Trendline(
                              name: "Tendência",
                              type: TrendlineType.polynomial,
                              color: Colors.red,
                              forwardForecast: 18,
                              enableTooltip: true)
                        ]),
                    LineSeries<AgricultureRow, String>(
                        color: Colors.green,
                        markerSettings: const MarkerSettings(isVisible: false),
                        name: "Área plantada",
                        yAxisName: "cropArea",
                        dataSource: snapshot.data as List<AgricultureRow>,
                        xValueMapper: (AgricultureRow value, _) =>
                            value.yearMonth,
                        yValueMapper: (AgricultureRow value, _) =>
                            value.cropArea),
                  ]),
            );
          }),
      const Padding(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: Text(
            "A produção da cana-de-açúcar no Paraná vem caindo nos últimos 5 "
            "anos. Uma regressão polinomial, com 93% de confiança, mostra que "
            "em um ano e meio, a produção será a metade em relação a 2017."),
      )
    ]);
  }

  Widget _buildEquipReport3() {
    final repo = EquipmentRepository();
    return ListView(children: [
      FutureBuilder(
          future: repo.getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return SizedBox(
                width: (window.physicalSize.shortestSide /
                    window.devicePixelRatio),
                height: 0.7 *
                    (window.physicalSize.longestSide / window.devicePixelRatio),
                child: SfCartesianChart(
                    margin: const EdgeInsets.only(
                        top: 15, left: 10, right: 10, bottom: 10),
                    primaryYAxis: NumericAxis(
                        title: AxisTitle(text: "Caminhões"),
                        numberFormat: NumberFormat.compact()),
                    primaryXAxis: CategoryAxis(),
                    axes: [
                      NumericAxis(
                          name: "cars",
                          title: AxisTitle(text: "Carros"),
                          opposedPosition: true,
                          numberFormat: NumberFormat.compact())
                    ],
                    title: ChartTitle(text: 'Produção de carros e caminhões'),
                    legend: Legend(
                        isVisible: true,
                        title: LegendTitle(
                            alignment: ChartAlignment.center,
                            text: "Fonte: ANFAVEA")),
                    tooltipBehavior: TooltipBehavior(enable: false),
                    series: <ChartSeries<EquipmentRow, String>>[
                      LineSeries<EquipmentRow, String>(
                          color: Colors.blue,
                          markerSettings:
                              const MarkerSettings(isVisible: false),
                          name: "Caminhões",
                          dataSource: snapshot.data as List<EquipmentRow>,
                          xValueMapper: (EquipmentRow value, _) =>
                              value.yearMonthStrLong(),
                          yValueMapper: (EquipmentRow value, _) =>
                              value.truckProduction),
                      LineSeries<EquipmentRow, String>(
                          color: Colors.green,
                          markerSettings:
                              const MarkerSettings(isVisible: false),
                          name: "Carros",
                          yAxisName: "cars",
                          dataSource: snapshot.data as List<EquipmentRow>,
                          xValueMapper: (EquipmentRow value, _) =>
                              value.yearMonthStrLong(),
                          yValueMapper: (EquipmentRow value, _) =>
                              value.carProduction),
                      AreaSeries(
                          name: "Pandemia (aprox.)",
                          color: const Color.fromARGB(109, 252, 127, 118),
                          dataSource: _selectPandemicRows(
                              (snapshot.data as List<EquipmentRow>)),
                          xValueMapper: (EquipmentRow value, _) =>
                              value.yearMonthStrLong(),
                          yValueMapper: (EquipmentRow value, _) =>
                              value.truckProduction)
                    ]));

            ;
          }),
      const Padding(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: Text(
            " A produção de caminhões está se recuperando bem dos impactos da "
            "pandemia, atingindo até níveis superiores a antes do fenômeno. "
            "Essa recuperação está melhor que o setor de carros, que ainda não"
            " reestabeleceu os níveis de produção."),
      )
    ]);
  }

  List<EquipmentRow> _selectPandemicRows(List<EquipmentRow> inputRows) {
    return inputRows.where((element) {
      return element.year() >= 2020 && element.year() < 2022;
    }).toList();
  }
}

Widget _buildEquipReport4() {
  final repo = EquipmentRepository();
  return ListView(children: [
    FutureBuilder(
        future: repo.getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return SizedBox(
              width:
                  (window.physicalSize.shortestSide / window.devicePixelRatio),
              height: 0.7 *
                  (window.physicalSize.longestSide / window.devicePixelRatio),
              child: SfCartesianChart(
                  margin: const EdgeInsets.only(
                      top: 15, left: 10, right: 10, bottom: 10),
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(text: "Produzidos/licenciados"),
                      numberFormat: NumberFormat.compact()),
                  primaryXAxis: CategoryAxis(),
                  title:
                      ChartTitle(text: 'Produção e licenciamento de caminhões'),
                  legend: Legend(
                      isVisible: true,
                      title: LegendTitle(
                          alignment: ChartAlignment.center,
                          text: "Fonte: ANFAVEA")),
                  tooltipBehavior: TooltipBehavior(enable: false),
                  series: <ChartSeries<EquipmentRow, String>>[
                    LineSeries<EquipmentRow, String>(
                        color: const Color.fromARGB(115, 63, 81, 181),
                        markerSettings: const MarkerSettings(isVisible: false),
                        name: "Produzidos",
                        dataSource: snapshot.data as List<EquipmentRow>,
                        xValueMapper: (EquipmentRow value, _) =>
                            value.yearMonthStr(),
                        yValueMapper: (EquipmentRow value, _) =>
                            value.truckProduction),
                    LineSeries<EquipmentRow, String>(
                        color: const Color.fromARGB(115, 76, 175, 79),
                        name: "Licenciados",
                        markerSettings: const MarkerSettings(isVisible: false),
                        dataSource: snapshot.data as List<EquipmentRow>,
                        xValueMapper: (EquipmentRow value, _) =>
                            value.yearMonthStr(),
                        yValueMapper: (EquipmentRow value, _) =>
                            value.truckLicensing),
                    LineSeries(
                        name: "Diferença",
                        dataSource: snapshot.data as List<EquipmentRow>,
                        xValueMapper: (EquipmentRow value, _) =>
                            value.yearMonthStr(),
                        yValueMapper: (EquipmentRow value, _) =>
                            value.truckProduction - value.truckLicensing),
                  ]));

          ;
        }),
    const Padding(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Text("A produção de caminhões no país parece acompanhar o número "
          "de licenciamentos, sempre aumentando após um crescimento das "
          "licenças. O mercado pode estar reagindo de forma exagerada à "
          "recuperação pós-pandemia, elevando a produção após picos "
          "insustentáveis de demanda. O número de licenciamentos na pandemia, "
          "que chegou a superar a produção, já previa o crescimento na "
          "demanda."),
    )
  ]);
}

class Point {
  Point(this.month, this.amount);
  final String month;
  final num amount;
}
