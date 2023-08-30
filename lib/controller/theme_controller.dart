import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const appThemeModeKey = 'appThemeMode';

class MyState extends ChangeNotifier {
  MyState() {
    _init();
  }
  late final SharedPreferences _sharedPreferences;

  var _lightMode = true;

  bool get ligthMode => _lightMode;

  void toggleTheme() {
    _lightMode = !_lightMode;
    _sharedPreferences.setBool(appThemeModeKey, _lightMode);
    notifyListeners();
  }

  Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _lightMode = _sharedPreferences.getBool(appThemeModeKey) ?? true;
    notifyListeners();
  }
}
