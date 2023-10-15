import 'package:flutter/material.dart';
import '../models/sales.dart';
import 'database.dart';

/// Defines a class that manages the state and operations of [Car_Infos] page,
/// including loading car data and deleting cars.
class SalesInfosState with ChangeNotifier {
  /// constructor initiates the class CarInfosState.
  SalesInfosState();

  /// creates an instance of a CarsController class.
  final controller = SalesController();

  Sale? _selectSale;

  /// Getter method, [selectSale], returns the
  /// value of a private variable _loggedUser.
  Sale? get selectSale => _selectSale;

  void setSale(Sale sale) async {
    _selectSale = sale;

    notifyListeners();
  }
}
