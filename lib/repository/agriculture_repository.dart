import '../database/database_manager.dart';

class AgricultureRepository {
  Future<List<AgricultureRow>> getData(String product, String state) async {
    final db = await DatabaseManager().getDatabase();
    List<Map<String, Object?>> queryMap = await db.query("dados_agro",
        where: "produto = ? AND estado = ?", whereArgs: [product, state]);
    List<AgricultureRow> dataRows = [];
    for (var element in queryMap) {
      dataRows.add(AgricultureRow.fromMap(element));
    }
    return dataRows;
  }

  Future<List<AgricultureWeatherRow>> getDataWithWeather(String state) async {
    final db = await DatabaseManager().getDatabase();
    List<Map<String, Object?>> queryMap =
        await db.query("agro_clima", where: "STATE = ?", whereArgs: [state]);
    List<AgricultureWeatherRow> dataRows = [];
    for (var element in queryMap) {
      dataRows.add(AgricultureWeatherRow.fromMap(element));
    }
    return dataRows;
  }
}

class AgricultureRow {
  String yearMonth;
  num cropYield;
  num cropArea;
  String product;
  String state;

  AgricultureRow(
      {required this.yearMonth,
      required this.cropYield,
      required this.cropArea,
      required this.product,
      required this.state});

  factory AgricultureRow.fromMap(Map<String, dynamic> map) {
    return AgricultureRow(
        yearMonth: map["ano_mes"],
        cropYield: map["producao"],
        cropArea: map["area_plantacao"],
        product: map["produto"],
        state: map["estado"]);
  }

  int year() {
    return int.parse(yearMonth.substring(0, 4));
  }

  int month() {
    return int.parse(yearMonth.substring(5, 6));
  }
}

class AgricultureWeatherRow {
  String yearMonth;
  num cropYield;
  String product;
  String state;
  num precipitation;
  num temperature;
  num? cropArea;

  AgricultureWeatherRow(
      {required this.yearMonth,
      required this.cropYield,
      required this.product,
      required this.state,
      required this.precipitation,
      required this.temperature,
      this.cropArea});

  factory AgricultureWeatherRow.fromMap(Map<String, dynamic> map) {
    return AgricultureWeatherRow(
        yearMonth: map["YEAR_MONTH"],
        cropYield: map["AMOUNT"],
        product: map["PRODUCT"],
        state: map["STATE"],
        precipitation: map['PRECIPITATION'],
        temperature: map['TEMPERATURE'],
        cropArea: map['CROP_AREA']);
  }

  int year() {
    return int.parse(yearMonth.substring(0, 4));
  }

  int month() {
    return int.parse(yearMonth.substring(5, 6));
  }
}
