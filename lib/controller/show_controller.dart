import 'package:flutter/material.dart';

import '../models/car.dart';
import '../models/user.dart';
import 'database.dart';

class ShowState extends ChangeNotifier {
  final controllerUser = UserController();
  final controllerCar = CarsController();
  final _listUser = <User>[];
  final _listCar = <Car>[];

  List<User> get listUser => _listUser;
  List<Car> get listCar => _listCar;

  ShowState() {
    loadDataUser();
    loadDataCar();
  }

  Future<void> loadDataUser() async {
    final list = await controllerUser.select();

    listUser
      ..clear()
      ..addAll(list);

    notifyListeners();
  }
  Future<void> loadDataCar() async {
    final list = await controllerCar.select();

    listCar
      ..clear()
      ..addAll(list);

    notifyListeners();
  }

}
