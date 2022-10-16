import 'package:calvin_boards/database/database_manager.dart';

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
  String yearMonth;
  int truckProduction;
  int carProduction;

  EquipmentRow(
      {required this.yearMonth,
      required this.truckProduction,
      required this.carProduction});

  factory EquipmentRow.fromMap(Map<String, dynamic> map) {
    return EquipmentRow(
        yearMonth: map["ano_mes"],
        truckProduction: map["producao_caminhoes"],
        carProduction: map["producao_carros"]);
  }

  int year() {
    return int.parse(yearMonth.substring(0, 4));
  }

  int month() {
    return int.parse(yearMonth.substring(5, 6));
  }
}
