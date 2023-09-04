import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/db_controller.dart';
import '../../controller/theme_controller.dart';
import '../../main.dart';

class DrawerMenu extends StatelessWidget {
  final String? shopName;
  final String? cnpj;
  final String? profilePicture;

  const DrawerMenu({
    super.key,
    this.shopName,
    this.cnpj,
    this.profilePicture,
  });

  Text showTittle(String texto) {
    return Text(
      texto,
      style: const TextStyle(fontSize: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider<UserState>(create: (_) => UserState());
    final state = Provider.of<MyState>(context);
    return ChangeNotifierProvider(
      create: (context) => UserState(),
      child: Consumer<UserState>(
        builder: (_, stateUser, __) {
          return Drawer(
            child: Center(
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
                        const Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white,
                        ),
                        Text(
                          UserState().userName,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          UserState().userCnpj.toString(),
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
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                  ListTile(
                    title: showTittle('Gerenciar'),
                    subtitle: const Text('Gerenciar Usuários'),
                    leading: const Icon(Icons.person_2),
                    iconColor: mainColor,
                    onTap: () {
                      Navigator.pushNamed(context, '/users');
                    },
                  ),
                  ListTile(
                    title: showTittle('Configurações'),
                    subtitle: const Text('Fazer ajustes na conta'),
                    leading: const Icon(Icons.brightness_7),
                    iconColor: mainColor,
                    onTap: () {},
                  ),
                  ListTile(
                    title: showTittle('Login'),
                    subtitle: const Text('Entrar na Conta'),
                    leading: const Icon(Icons.login),
                    iconColor: mainColor,

                    //ir para a pagina inicial
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  ListTile(
                    title: showTittle('Register'),
                    subtitle: const Text('Registrar um usuário'),
                    leading: const Icon(Icons.app_registration),
                    iconColor: mainColor,
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                  ListTile(
                    title: showTittle('Logout'),
                    subtitle: const Text('Sair do aplicativo'),
                    leading: const Icon(Icons.logout),
                    iconColor: mainColor,
                    onTap: () {},
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
            ),
          );
        },
      ),
    );
  }
}
