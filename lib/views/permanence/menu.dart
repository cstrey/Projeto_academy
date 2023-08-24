import 'package:flutter/material.dart';
import 'package:projeto_lince/main.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  //dados que vem do banco de dados
  final String shopName;
  final String cnpj;
  final String profilePicture;

  const DrawerMenu({
    super.key,
    required this.shopName,
    required this.cnpj,
    required this.profilePicture,
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
    return Drawer(
      child: Center(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
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
                  Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white,
                  ),
                  Text(
                    "Cauan",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "21213",
                    style: TextStyle(
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
                Navigator.pushNamed(context, "/");
              },
            ),
            ListTile(
              title: showTittle('Gerenciar'),
              subtitle: const Text('Gerenciar Usuários'),
              leading: const Icon(Icons.person_2),
              iconColor: mainColor,
              onTap: () {
                Navigator.pushNamed(context, "/users");
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
                Navigator.pushNamed(context, "/login");
              },
            ),
            ListTile(
              title: showTittle('Logout'),
              subtitle: const Text('Sair do aplicativo'),
              leading: const Icon(Icons.logout),
              iconColor: mainColor,

              //ir para a pagina inicial
              onTap: () {
                Navigator.pushNamed(context, "/register");
              },
            ),
            IconButton(
              alignment: Alignment.bottomLeft,
              onPressed: () => state.toggleTheme(),
              icon: Icon(
                state.ligthMode ? Icons.dark_mode : Icons.light_mode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
