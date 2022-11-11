import 'dart:ffi';
import 'package:flutter/material.dart';

class Car extends ChangeNotifier {
  int? id;
  String manufacturer;
  String model;
  String plate;
  int year;
  int mileage;

  Car(
      {this.id,
      required this.manufacturer,
      required this.model,
      required this.plate,
      required this.year,
      required this.mileage});

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
        id: map['car_id'],
        manufacturer: map['manufacturer'],
        model: map['model'],
        plate: map['plate'],
        year: map['year'],
        mileage: map['mileage']);
  }
}
