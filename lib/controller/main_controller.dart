import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

const appThemeModeKey = 'appThemeMode';

class MyState extends ChangeNotifier {
  MyState() {
    unawaited(_init());
  }
  late final SharedPreferences _sharedPreferences;

  var _lightMode = true;

  bool get ligthMode => _lightMode;

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

  User? _loggedUser;
  User? get loggedUser => _loggedUser;

  void setLoggedUser(User? user) {
    _loggedUser = user;

    notifyListeners();
  }
}
