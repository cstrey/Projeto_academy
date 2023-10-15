import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/main_controller.dart';
import '../../controller/user_controller.dart';
import '../../main.dart';

/// Declaration of a widget class named [DrawerMenu]
/// that extends StatelessWidget.
class DrawerMenu extends StatelessWidget {
  /// Define a constructor [DrawerMenu].
  const DrawerMenu({
    super.key,
  });

  /// Defines a function named [showTitle] that takes a single
  /// argument [text], which is a string.
  Text showTittle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyState>(context);
    return Consumer<UserState>(
      builder: (_, stateUser, __) {
        return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xff00456A),
                      Color(0xff051937),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      state.loggedUser!.name,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      state.loggedUser!.cnpj.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: showTittle('Home'),
                subtitle: const Text('Pagina Inicial'),
                leading: const Icon(Icons.home),
                iconColor: mainColor,
                onTap: () async {
                  await Navigator.pushReplacementNamed(context, '/');
                },
              ),
              if (state.loggedUser!.id == 1)
                ListTile(
                  title: showTittle('Gerenciar Usuários'),
                  subtitle: const Text('Visualizar Usuários'),
                  leading: const Icon(Icons.person_2),
                  iconColor: mainColor,
                  onTap: () async {
                    await Navigator.pushReplacementNamed(context, '/users');
                  },
                ),
              ListTile(
                title: showTittle('Gerenciar Veículos'),
                subtitle: const Text('Visualizar Veículos'),
                leading: const Icon(Icons.view_agenda),
                iconColor: mainColor,
                onTap: () async {
                  await Navigator.pushReplacementNamed(context, '/cars');
                },
              ),
              ListTile(
                title: showTittle('Veículos'),
                subtitle: const Text('Registrar um Veículo'),
                leading: const Icon(Icons.car_repair),
                iconColor: mainColor,
                onTap: () async {
                  await Navigator.pushReplacementNamed(
                    context,
                    '/registerCar',
                    arguments: state.loggedUser,
                  );
                },
              ),
              if (state.loggedUser!.id == 1)
                ListTile(
                  title: showTittle('Usuários'),
                  subtitle: const Text('Registrar um usuário'),
                  leading: const Icon(Icons.app_registration),
                  iconColor: mainColor,
                  onTap: () async {
                    await Navigator.pushReplacementNamed(context, '/register');
                  },
                ),
              ListTile(
                title: showTittle('Logout'),
                subtitle: const Text('Sair do aplicativo'),
                leading: const Icon(Icons.login),
                iconColor: mainColor,
                onTap: () async {
                  await Navigator.pushReplacementNamed(context, '/login');
                },
              ),
              IconButton(
                alignment: Alignment.bottomLeft,
                onPressed: state.toggleTheme,
                icon: Icon(
                  state.ligthMode ? Icons.dark_mode : Icons.light_mode,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
