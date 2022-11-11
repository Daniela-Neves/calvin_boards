import '../database/database_manager.dart';
import '../models/car.dart';

class CarRepository {
  Future<List<Car>> listarCarro() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
          SELECT 
            car.manufacturer, 
            car.model, 
            car.plate, 
            car.year, 
            car.mileage
          FROM car
''');
    return rows
        .map(
          (row) => Car(
              id: row['car_id'],
              manufacturer: row['manufacturer'],
              model: row['model'],
              plate: row['plate'],
              year: row['year'],
              mileage: row['mileage']),
        )
        .toList();
  }

  Future<bool> cadastrarCarro(Car car) async {
    final db = await DatabaseManager().getDatabase();
    try {
      db.insert("car", {
        "car_id": car.id,
        "manufacturer": car.manufacturer,
        "model": car.model,
        "plate": car.plate,
        "year": car.year,
        "mileage": car.mileage,
      });
    } catch (e) {
      rethrow;
    }
    return true;
  }

  Future<void> removerCarro(int id) async {
    final db = await DatabaseManager().getDatabase();
    await db.delete('car', where: 'car_id = ?', whereArgs: [id]);
  }

  Future<int> editarCarro(Car car) async {
    final db = await DatabaseManager().getDatabase();
    return db.update(
        'car',
        {
          "car_id": car.id,
          "manufacturer": car.manufacturer,
          "model": car.model,
          "plate": car.plate,
          "year": car.year,
          "mileage": car.mileage,
        },
        where: 'car_id = ?',
        whereArgs: [car.id]);
  }

}
