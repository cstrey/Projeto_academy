import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/theme_controller.dart';
import 'views/login_page.dart';
import 'views/main_page.dart';
import 'views/register_page.dart';
import 'views/users.dart';

const Color mainColor = Color.fromARGB(255, 57, 57, 196);

void main() {
  runApp(const MyApp());
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
            initialRoute: '/',
            routes: {
              '/': (context) => const MainPage(title: 'Anderson Automóveis'),
              '/login': (context) => LoginPage(),
              '/register': (context) => RegisterPage(),
              '/users': (context) =>
                  const ShowUsers(title: 'Anderson Automóveis'),
            },
          );
        },
      ),
    );
  }
}
