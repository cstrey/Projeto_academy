import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/car.dart';
import '../models/user.dart';
import 'database.dart';

const appThemeModeKey = 'appThemeMode';

class MyState extends ChangeNotifier {
  MyState() {
    unawaited(_init());
  }
  late final SharedPreferences _sharedPreferences;

  var _lightMode = true;

  bool get ligthMode => _lightMode;

  bool loading = true;

  final _carList = <Car>[];
  List<Car> get carList => _carList;

  final _userList = <User>[];
  List<User> get userList => _userList;

  int? _dealershipController;
  int? get dealershipController => _dealershipController;

  final _carsController = CarsController();

  final _userController = UserController();

  Future<void> toggleTheme() async {
    _lightMode = !_lightMode;
    await _sharedPreferences.setBool(appThemeModeKey, _lightMode);
    notifyListeners();
  }

  Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _lightMode = _sharedPreferences.getBool(appThemeModeKey) ?? true;
    notifyListeners();
  }

  Future<void> getVehicles() async {
    loading = true;

    int? dealershipId = 0;

    loggedUser?.id == 1
        ? dealershipId = _dealershipController ?? 1
        : dealershipId = loggedUser!.id;

    final result = await _carsController.selectByDealership(dealershipId!);

    //result.removeWhere((element) => element.isSold == true);

    _carList
      ..clear()
      ..addAll(result.reversed);

    loading = false;

    notifyListeners();
  }

  Future<void> getDealerships() async {
    final result = await _userController.selectAll();

    _userList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }

  void setDealership(User user) async {
    _dealershipController = user.id!;
    await getVehicles();

    notifyListeners();
  }

  User? _loggedUser;
  User? get loggedUser => _loggedUser;

  void setLoggedUser(User? user) {
    _loggedUser = user;

    notifyListeners();
  }
}
