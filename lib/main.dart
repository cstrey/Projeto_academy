import 'package:flutter/material.dart';
import 'package:projeto_lince/views/login_page.dart';
import 'package:projeto_lince/views/register_page.dart';
import 'package:projeto_lince/views/main_page.dart';
import 'package:projeto_lince/views/users.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const appThemeModeKey = "appThemeMode";

const Color mainColor = Color.fromARGB(255, 57, 57, 196);

void main() {
  runApp(const MyApp());
}

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyState(),
      child: Consumer<MyState>(
        builder: (context, state, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.ligthMode ? ThemeData.light() : ThemeData.dark(),
            initialRoute: "/register",
            routes: {
              "/": (context) => const MainPage(title: "Anderson Automóveis"),
              "/login": (context) => LoginPage(),
              "/register": (context) => const RegisterPage(),
              "/users": (context) =>
                  const ShowUsers(title: "Anderson Automóveis"),
            },
          );
        },
      ),
    );
  }
}
