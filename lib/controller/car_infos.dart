import 'package:flutter/material.dart';
import '../models/car.dart';
import 'database.dart';

/// Defines a class that manages the state and operations of [Car_Infos] page,
/// including loading car data and deleting cars.
class CarInfosState with ChangeNotifier {
  /// constructor initiates the class CarInfosState.
  CarInfosState(this.car);

  /// creates an instance of a CarsController class.
  final carController = CarsController();

  /// Creation a variable [car] which is not initialized but
  /// will be assigned a value later.
  final Car car;

  /// Remove a car from the database
  void deleteVehicle(Car car) async {
    await carController.delete(car);

    notifyListeners();
  }
}
