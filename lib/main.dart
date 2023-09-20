import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/cars_controller.dart';
import 'controller/theme_controller.dart';
import 'controller/user_controller.dart';
import 'views/login_page.dart';
import 'views/main_page.dart';
import 'views/register_cars.dart';
import 'views/register_page.dart';
import 'views/show_cars.dart';
import 'views/show_users.dart';

const Color mainColor = Color.fromARGB(255, 57, 57, 196);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyState(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserState(),
        ),
        ChangeNotifierProvider(
          create: (context) => CarState(),
        ),
      ],
      child: Consumer<MyState>(
        builder: (context, state, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.ligthMode ? ThemeData.light() : ThemeData.dark(),
            initialRoute: '/',
            routes: {
              '/': (context) => const MainPage(),
              '/login': (context) => const LoginPage(),
              '/register': (context) => const RegisterPage(),
              '/registerCar': (context) => const RegisterCarsPage(),
              '/users': (context) => const ShowUsers(),
              '/cars': (context) => const ShowCars(),
            },
          );
        },
      ),
    );
  }
}
