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
