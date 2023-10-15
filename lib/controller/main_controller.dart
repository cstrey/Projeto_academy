import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/car.dart';
import '../models/user.dart';
import 'database.dart';

/// Defines a constant variable named [appThemeModeKey] and assigns a string.
const appThemeModeKey = 'appThemeMode';

/// Class used to manage and update the state related to [main app] data.
class MyState extends ChangeNotifier {
  /// constructor initiates the loading of data.
  MyState() {
    unawaited(_init());
  }
  late final SharedPreferences _sharedPreferences;

  var _lightMode = true;

  /// Defines a getter method that allows you to access
  /// the value of the _lightMode.
  bool get ligthMode => _lightMode;

  /// This variable can be used to track whether something is currently
  /// in a [loading] state,
  bool loading = true;

  final _carList = <Car>[];

  /// Used to load a list of [Car] objects
  List<Car> get carList => _carList;

  final _userList = <User>[];

  /// Used to load a list of [user] objects
  List<User> get userList => _userList;

  int? _dealershipController;

  /// allows retrieve the value of a [_dealershipController].
  int? get dealershipController => _dealershipController;

  final _carsController = CarsController();

  final _userController = UserController();

  /// Used to toggle between two theme modes (light and dark).
  /// It saves the current theme mode
  /// to persistent storage using SharedPreferences.
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

  /// Fetches a list of vehicles from a dealership
  /// (based on the condition [loggedUser] and [_dealershipController])
  Future<void> getCar() async {
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

  /// Fetch data from the _userController and
  /// update the _userList with the result.
  Future<void> getDealerships() async {
    final result = await _userController.selectAll();

    _userList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }

  /// Sets a variable [_dealershipController] with the user's ID and
  /// fetches car information,
  void setDealership(User user) async {
    _dealershipController = user.id!;
    await getCar();

    notifyListeners();
  }

  User? _loggedUser;

  /// Getter method, loggedUser, returns the
  /// value of a private variable _loggedUser.
  User? get loggedUser => _loggedUser;

  /// Updating a user logged-in state.
  void setLoggedUser(User? user) {
    _loggedUser = user;

    notifyListeners();
  }
}
