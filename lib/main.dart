import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/main_controller.dart';
import 'controller/user_controller.dart';
import 'views/car_information.dart';
import 'views/login_page.dart';
import 'views/main_page.dart';
import 'views/register_cars.dart';
import 'views/register_page.dart';
import 'views/register_sales.dart';
import 'views/sales_information.dart';
import 'views/show_cars.dart';
import 'views/show_sales.dart';
import 'views/show_users.dart';

/// Declares a const Color variable [mainColor], which cannot be modified.
const Color mainColor = Color.fromARGB(255, 57, 57, 196);

/// Declares a const String variable [title], which cannot be modified.
const String title = 'Anderson Automóveis';
void main() {
  runApp(const MyApp());
}

/// Declaration of a widget class named [MyApp] that extends StatelessWidget.
class MyApp extends StatelessWidget {
  /// Define a constructor [MyApp].
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
      ],
      child: Consumer<MyState>(
        builder: (context, state, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.ligthMode ? ThemeData.light() : ThemeData.dark(),
            initialRoute: '/login',
            routes: {
              '/': (context) => const MainPage(),
              '/login': (context) => const LoginPage(),
              '/register': (context) => const RegisterPage(),
              '/registerCar': (context) => const RegisterCarsPage(),
              '/registerSale': (context) => const RegisterSalePage(),
              '/users': (context) => const ShowUsers(),
              '/cars': (context) => const ShowCars(),
              '/carInfos': (context) => const CarInfos(),
              '/salesInfos': (context) => const SalesInfos(),
              '/sales': (context) => const ShowSales(),
            },
          );
        },
      ),
    );
  }
}
