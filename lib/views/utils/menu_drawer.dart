import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/theme_controller.dart';
import '../../controller/user_controller.dart';
import '../../main.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
  });

  Text showTittle(String texto) {
    return Text(
      texto,
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
                title: showTittle('Gerenciar Vendas'),
                subtitle: const Text('Visualizar Vendas'),
                leading: const Icon(Icons.shopping_bag),
                iconColor: mainColor,
                onTap: () async {
                  await Navigator.pushReplacementNamed(context, '/');
                },
              ),
              ListTile(
                title: showTittle('Vendas'),
                subtitle: const Text('Registrar uma Venda'),
                leading: const Icon(Icons.sell),
                iconColor: mainColor,
                onTap: () async {
                  await Navigator.pushReplacementNamed(
                      context, '/registerSale');
                },
              ),
              ListTile(
                title: showTittle('Veículos'),
                subtitle: const Text('Registrar um Veículo'),
                leading: const Icon(Icons.car_repair),
                iconColor: mainColor,
                onTap: () async {
                  await Navigator.pushReplacementNamed(context, '/registerCar');
                },
              ),
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
