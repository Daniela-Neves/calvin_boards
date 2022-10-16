import 'package:calvin_boards/database/database_manager.dart';
import 'package:intl/intl.dart';

class EquipmentRepository {
  Future<List<EquipmentRow>> getData() async {
    final db = await DatabaseManager().getDatabase();
    List<Map<String, Object?>> queryMap = await db.query("dados_equip");
    List<EquipmentRow> dataRows = [];
    for (var element in queryMap) {
      dataRows.add(EquipmentRow.fromMap(element));
    }
    return dataRows;
  }
}

class EquipmentRow {
  int truckProduction;
  int carProduction;
  int truckLicensing;
  int timestamp;

  EquipmentRow(
      {required this.timestamp,
      required this.truckProduction,
      required this.carProduction,
      required this.truckLicensing});

  factory EquipmentRow.fromMap(Map<String, dynamic> map) {
    return EquipmentRow(
        timestamp: map['data'],
        truckLicensing: map['licenciamento_caminhoes'],
        truckProduction: map["producao_caminhoes"],
        carProduction: map["producao_carros"]);
  }

  int year() {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).year;
  }

  int month() {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).month;
  }

  String yearMonthStr() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.year}-${date.month.toString().padLeft(2, '0')}';
  }

  String yearMonthStrLong() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.year}-${DateFormat("MMM", 'pt_BR').format(date)}';
  }

  Future<List<EquipmentRow>> getData(
      int startYear, int startMonth, int endYear, int endMonth) async {
    int startTimestamp = DateTime(startYear, startMonth).millisecondsSinceEpoch;
    int endTimestamp = DateTime(endYear, endMonth).millisecondsSinceEpoch;
    final db = await DatabaseManager().getDatabase();
    var rows = await db.query("dados_equip",
        where: "data BETWEEN ? AND ?",
        whereArgs: [startTimestamp / 1000, endTimestamp / 1000]);
    List<EquipmentRow> rowsToReturn = [];
    for (var row in rows) {
      rowsToReturn.add(EquipmentRow.fromMap(row));
    }
    return rowsToReturn;
  }
}
